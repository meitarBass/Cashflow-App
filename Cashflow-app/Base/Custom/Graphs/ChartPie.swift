//
//  ChartPie.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 11/10/2020.
//

import UIKit

extension ChartPie {
    
    struct Appearance {
        
        let lineWidth: CGFloat = 10.0
        let radius: CGFloat = 70.0
    }
}

struct CirclePath {
    let fromColor: UIColor
    let toColor: UIColor
    let data: CGFloat
    
    var startAngle: CGFloat?
    var endAngle: CGFloat?
    var path: CGPath?
    
//    let category: Categories?

    init(fromColor: UIColor, toColor: UIColor, data: CGFloat) {
        self.fromColor = fromColor
        self.toColor = toColor
        self.data = data
    }
    
    mutating func createPath(totalVal: CGFloat) {
        let endAngle = startAngle! + 2 * CGFloat.pi * (self.data / totalVal)
        let path = UIBezierPath(arcCenter: .zero, radius: 70, startAngle: startAngle!, endAngle: endAngle, clockwise: true)
        self.path = path.cgPath
    }
}

class ChartPie: UIView {
    
    let appearance = Appearance()
    
    var amounts: [CGFloat] =  [20.0, 40.0, 60.0]
    var total: CGFloat = 120
    
    private var colors: [UIColor]?
    private var pulsatingColor: UIColor?
    private var pulsatingLayer: CAShapeLayer!
    private var textLayer: CATextLayer!
    
    private var circleLayers: [CAShapeLayer] = [CAShapeLayer]()
    
    private var data: Int!

    let circularPath = UIBezierPath(arcCenter: .zero, radius: 70, startAngle: 0,
                                    endAngle: 2 * CGFloat.pi, clockwise: true)
    
    init(frame: CGRect, fromColor: UIColor, toColor: UIColor, pulsatingColor: UIColor, data: Int) {
        super.init(frame: frame)
        colors = [fromColor, toColor]
        self.pulsatingColor = pulsatingColor
        self.data = data
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        setupNotificiationObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        guard let pulsatingColor = self.pulsatingColor else { return }
        pulsatingLayer = createCircleShapeLayer(path: circularPath.cgPath, strokeColor: pulsatingColor,fillColor: .clear, center: center)
        
        var endAngle: CGFloat = CGFloat(0)
        
        let trackLayer = createCircleShapeLayer(path: circularPath.cgPath, strokeColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), fillColor: .white, center: center)
        layer.addSublayer(pulsatingLayer)
        layer.addSublayer(trackLayer)
        
        for item in amounts {
            var path = CirclePath(fromColor: .red, toColor: .green, data: item)
            path.startAngle = endAngle
            path.createPath(totalVal: total)
            
            endAngle = path.startAngle! + 2 * CGFloat.pi * (item / total)
                        
            let layer = createCircleShapeLayer(path: path.path!, strokeColor: .white, fillColor: .clear, center: center)
            
            circleLayers.append(layer)
            self.addGradient(path: path, circleLayer: layer)
        }
    }
    
    private func animatePulsingLayer() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        animation.toValue = 1.1
        animation.duration = 0.5
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        
        pulsatingLayer.add(animation, forKey: "pulsing")
    }
    
    private func setupNotificiationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleEnterForeground), name: .NSExtensionHostWillEnterForeground, object: nil)
    }
    
    private func createCircleShapeLayer(path: CGPath, strokeColor: UIColor, fillColor: UIColor, center: CGPoint) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.path = path
        layer.strokeColor = strokeColor.cgColor
        layer.fillColor = fillColor.cgColor
        layer.lineWidth = 10.0
        layer.lineCap = CAShapeLayerLineCap.round
        layer.position = center
        layer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        
        return layer
    }
    
    private func createPath(pathVal: CGFloat, totalVal: CGFloat, startAngle: CGFloat) -> CGPath {
        let endAngle = 2 * CGFloat.pi * (pathVal / totalVal)
        let path = UIBezierPath(arcCenter: .zero, radius: 70, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        return path.cgPath
    }
    
    private func createTextLayer(textColor: UIColor) -> CATextLayer {
        
        let width = frame.size.width
        let height = frame.size.height
        
        let fontSize = min(width, height) / 4 - 5
        let offset = min(width, height) * 0.1
        
        let layer = CATextLayer()
        layer.string = "\(Int(data * 100))"
        layer.backgroundColor = UIColor.clear.cgColor
        layer.foregroundColor = textColor.cgColor
        layer.font = UIFont(name: "AmericanTypewriter", size: fontSize)
        layer.frame = CGRect(x: 0, y: (height - fontSize - offset) / 2, width: width, height: height)
        layer.alignmentMode = .center
        
        return layer
      }
    
    @objc private func handleEnterForeground() {
        animatePulsingLayer()
    }
    
    @objc private func handleTap() {
        
        for layer in circleLayers {
            let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
            basicAnimation.fromValue = 0.0
            
            basicAnimation.duration = 2.0
            basicAnimation.fillMode = CAMediaTimingFillMode.forwards
            basicAnimation.isRemovedOnCompletion = false
            basicAnimation.toValue = 1.0
            
            layer.strokeEnd = 1.0
            layer.add(basicAnimation, forKey: "urSoBasic")
        }
    
        animatePulsingLayer()
    }
    
    private func addGradient(path: CirclePath, circleLayer: CAShapeLayer) {
        let gradient = CAGradientLayer()
        
        let startAngle = path.startAngle!
        let endAngle = path.startAngle! + 2 * CGFloat.pi * (path.data / total)
        
        gradient.startPoint = transformPoint(point: CGPoint(x: sin(startAngle), y: cos(startAngle)))
        gradient.endPoint = transformPoint(point: CGPoint(x: sin(endAngle), y: cos(endAngle)))
            
        gradient.locations = [0.0, 1.0]
        
        gradient.colors = [path.fromColor.cgColor, path.toColor.cgColor]
        gradient.frame = bounds
        gradient.mask = circleLayer
        
        layer.addSublayer(gradient)
    }
    
    private func transformPoint(point: CGPoint) -> CGPoint {
        
        let xVal: CGFloat = (1 + point.x) / 2
        let yVal: CGFloat = (1 - point.y) / 2
        
        return CGPoint(x: xVal, y: yVal)
    }
}
