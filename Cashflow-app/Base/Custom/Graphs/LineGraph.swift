//
//  LineGraph.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 11/10/2020.
//

import UIKit

extension LineGraph {
    
    struct Appearance {
        let cornerRadiusSize = CGSize(width: 8.0, height: 8.0)
        let margin: CGFloat = 50.0
        let topBorder: CGFloat = 60
        let bottomBorder: CGFloat = 50
        let colorAlpha: CGFloat = 0.3
        let circleDiameter: CGFloat = 5.0
    }
}

class LineGraph: UIView {
    
    var graphPoints = [4, 3, 2, 5, 6]
    var startColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
    var endColor = #colorLiteral(red: 0.9274237752, green: 0.8423518538, blue: 0.6862384677, alpha: 1)
    
    let appearance = Appearance()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        createView(rect: rect, cornerRadius: appearance.cornerRadiusSize)
        
        let (context, gradient) = createGradientBackground(startColor: startColor, endColor: endColor)
        
        guard let updatedContext = context, let updatedGradient = gradient else { return }
//        calculateGraphPoints(rect: rect, )
        
        // Calculate the x point
        
        let (columnXPoint, YPoints, max) = calculateGraphPoints(rect: rect, margin: appearance.margin, graphPoints: self.graphPoints, topBorder: appearance.topBorder, bottomBorder: appearance.bottomBorder)
        
        guard let columnYPoint = YPoints, let maxValue = max else { return }
        
        // Change colours
        
        UIColor.white.setFill()
        UIColor.white.setStroke()

        // Set up the points line
        let graphPath = UIBezierPath()
        
        drawGraphLine(graphPath: graphPath, columnXPoint: columnXPoint,
                      columnYPoint: columnYPoint, graphPoints: self.graphPoints)
        
        drawGraphCircles(graphPoints: self.graphPoints, columnXPoint: columnXPoint, columnYPoint: columnYPoint, circleDiameter: appearance.circleDiameter)
        
        
        createClip(updatedContext: updatedContext, graphPath: graphPath, columnXPoint: columnXPoint, columnYPoint: columnYPoint, rect: rect, graphPoints: graphPoints, updatedGradient: updatedGradient, maxValue: maxValue, margin: appearance.margin)
        
        drawLines(margin: appearance.margin, topBorder: appearance.topBorder,
                  bottomBorder: appearance.bottomBorder, rect: rect,
                  colorAlpha: appearance.colorAlpha)
      }
}

extension UIView {
    func createView(rect: CGRect, cornerRadius: CGSize) {
        let path = UIBezierPath(
          roundedRect: rect,
          byRoundingCorners: .allCorners,
          cornerRadii: cornerRadius
        )
        path.addClip()
    }
    
    func createGradientBackground(startColor: UIColor, endColor: UIColor) -> (CGContext?, CGGradient?) {
        // 2
        guard let context = UIGraphicsGetCurrentContext() else { return (nil, nil) }
        let colors = [startColor.cgColor, endColor.cgColor]
        
        // 3
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // 4
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        // 5
        guard let gradient = CGGradient(
          colorsSpace: colorSpace,
          colors: colors as CFArray,
          locations: colorLocations
        ) else { return (context, nil) }
        
        // 6
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        context.drawLinearGradient(
          gradient,
          start: startPoint,
          end: endPoint,
          options: []
        )
        
        return (context, gradient)
    }
    
    func calculateGraphPoints(rect: CGRect, margin: CGFloat, graphPoints: [Int],
                              topBorder: CGFloat, bottomBorder: CGFloat)
                              -> (((Int) -> CGFloat), ((Int)-> CGFloat)?, Int?) {
        // Calculate the x point

        let margin = margin
        let graphWidth = rect.width - margin * 2
        let columnXPoint = { (column: Int) -> CGFloat in
          // Calculate the gap between points
          let spacing = graphWidth / CGFloat(graphPoints.count - 1)
          return CGFloat(column) * spacing + margin + 2
        }

        // Calculate the y point

        let graphHeight = rect.height - topBorder - bottomBorder
        guard let maxValue = graphPoints.max() else { return (columnXPoint, nil, nil)}
        let columnYPoint = { (graphPoint: Int) -> CGFloat in
          let yPoint = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
          return graphHeight + topBorder - yPoint // Flip the graph
        }
                                  
        return (columnXPoint, columnYPoint, maxValue)
    }
    
    func drawGraphLine(graphPath: UIBezierPath, columnXPoint: (Int) -> CGFloat,
                       columnYPoint: (Int) -> CGFloat, graphPoints: [Int]) {
        // Go to start of line
        graphPath.move(to: CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoints[0])))

        // Add points for each item in the graphPoints array
        // at the correct (x, y) for the point
        for i in 1..<graphPoints.count {
          let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
          graphPath.addLine(to: nextPoint)
        }
        // Draw the line on top of the clipped gradient
        graphPath.lineWidth = 2.0
        graphPath.lineCapStyle = .round
        graphPath.stroke()
    }
    
    func drawGraphCircles(graphPoints: [Int],
                          columnXPoint: (Int) -> CGFloat,
                          columnYPoint: (Int) -> CGFloat,
                          circleDiameter: CGFloat) {
        // Draw the circles on top of the graph stroke
        for i in 0..<graphPoints.count {
          var point = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
          point.x -= circleDiameter / 2
          point.y -= circleDiameter / 2

          let circle = UIBezierPath(
            ovalIn: CGRect(
              origin: point,
              size: CGSize(
                width: circleDiameter,
                height: circleDiameter)
            )
          )
          circle.fill()
        }
    }
    
    func createClip(updatedContext: CGContext, graphPath: UIBezierPath,
                    columnXPoint: (Int) -> CGFloat, columnYPoint: (Int) -> CGFloat,
                    rect: CGRect, graphPoints: [Int], updatedGradient: CGGradient,
                    maxValue: Int, margin: CGFloat) {
        // Create the clipping path for the graph gradient

        // 1 - Save the state of the context (commented out for now)
        updatedContext.saveGState()

        // 2 - Make a copy of the path
        guard let clippingPath = graphPath.copy() as? UIBezierPath else { return }

        // 3 - Add lines to the copied path to complete the clip area
        clippingPath.addLine(to: CGPoint(
          x: columnXPoint(graphPoints.count - 1),
                                y: rect.height))
        clippingPath.addLine(to: CGPoint(x: columnXPoint(0), y: rect.height))
        clippingPath.close()

        // 4 - Add the clipping path to the context
        clippingPath.addClip()

        // 5 - Check clipping path - Temporary code
        let highestYPoint = columnYPoint(maxValue)
        let graphStartPoint = CGPoint(x: margin, y: highestYPoint)
        let graphEndPoint = CGPoint(x: margin, y: bounds.height)

        updatedContext.drawLinearGradient(
          updatedGradient,
          start: graphStartPoint,
          end: graphEndPoint,
          options: [])
        updatedContext.restoreGState()
        // End temporary code
    }
    
    func drawLines(margin: CGFloat, topBorder: CGFloat, bottomBorder: CGFloat,
                   rect: CGRect, colorAlpha: CGFloat) {
        // Draw horizontal graph lines on the top of everything
        let linePath = UIBezierPath()

        // Top line
        linePath.move(to: CGPoint(x: margin, y: topBorder))
        linePath.addLine(to: CGPoint(x: rect.width - margin, y: topBorder))

        // Center line
        linePath.move(to: CGPoint(x: margin,
                                  y: (rect.height - topBorder - bottomBorder) / 2 + topBorder))
        linePath.addLine(to: CGPoint(x: rect.width - margin,
                                     y: (rect.height - topBorder - bottomBorder) / 2 + topBorder))

        // Bottom line
        linePath.move(to: CGPoint(x: margin, y: rect.height - bottomBorder))
        linePath.addLine(to: CGPoint(x: rect.width - margin, y: rect.height - bottomBorder))
        let color = UIColor(white: 1.0, alpha: colorAlpha)
        color.setStroke()
            
        linePath.lineWidth = 1.0
        linePath.stroke()
    }
}
