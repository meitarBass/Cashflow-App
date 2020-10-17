//
//  ChartPie.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 11/10/2020.
//

import UIKit

struct CirclePath {
    
    let fromColor: UIColor
    let toColor: UIColor
    let data: CGFloat
    
    var startAngle: CGFloat?
    var endAngle: CGFloat?
    var path: CGPath?
    
    let category: categories?

    init(fromColor: UIColor, toColor: UIColor, data: CGFloat, category: categories) {
        self.fromColor = fromColor
        self.toColor = toColor
        self.data = data
        
        self.category = category
    }
    
    mutating func createPath(totalVal: CGFloat, radius: CGFloat?) {
        let endAngle = startAngle! + 2 * CGFloat.pi * (self.data / totalVal)
        let path = UIBezierPath(arcCenter: .zero, radius: radius ?? 65, startAngle: startAngle!, endAngle: endAngle, clockwise: true)
        self.path = path.cgPath
    }
}

class ChartPie: UIView {
    
    private var pulsatingColor: UIColor?
    private var pulsatingLayer: CAShapeLayer?
    
    private var circleLayers: [CAShapeLayer] = [CAShapeLayer]()
    
    private var expenses: [categories : Int]?
    private var radius: CGFloat?
    private var absTotal: CGFloat?
    private var expensesSavingsTotal: CGFloat?
    
    init(frame: CGRect, pulsatingColor: UIColor) {
        super.init(frame: frame)
        self.pulsatingColor = pulsatingColor
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        setupNotificiationObservers()
    }
    
    func setupUI(expenses: [categories : Int], total: CGFloat, radius: CGFloat) {
        self.absTotal = total
        self.expenses = expenses
        self.radius = radius
    }
    
    func setupUIforExpensesSavings(expensesTotal: Int, savingsTotal: Int,
                                   radius: CGFloat) {
        self.expenses = [.expenses : abs(expensesTotal),
                         .savingsCategory: savingsTotal]
        self.absTotal = CGFloat(abs(expensesTotal) + savingsTotal)
        self.expensesSavingsTotal = CGFloat(expensesTotal + savingsTotal)
        self.radius = radius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        createAdditionalLayers(center: center)
        
        var endAngle: CGFloat = CGFloat(0)
    
        guard let expenses = self.expenses, let total = self.absTotal else { return }
        for (category, amount) in expenses {
            var path = CirclePath(fromColor: .white, toColor: .white,
                                  data: CGFloat(amount), category: category)
            path.startAngle = endAngle
            path.createPath(totalVal: total, radius: radius)
            endAngle = path.startAngle! + 2 * CGFloat.pi * (CGFloat(amount) / total)
                        
            let layer = createCircleShapeLayer(path: path.path!, strokeColor: .white, fillColor: .clear, center: center)
            
            circleLayers.append(layer)
            self.addGradient(path: path, total: total, circleLayer: layer)
        }
    }
    
    private func createAdditionalLayers(center: CGPoint) {
        guard let pulsatingColor = self.pulsatingColor else { return }
        // Create pulsating layer
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: radius ?? 65, startAngle: 0,
                                        endAngle: 2 * CGFloat.pi, clockwise: true)
        
        pulsatingLayer = createCircleShapeLayer(path: circularPath.cgPath,
                                               strokeColor: pulsatingColor,
                                               fillColor: .clear,
                                               center: center)
        
        guard let pulsatingLayer = self.pulsatingLayer else { return }
        
        
        layer.addSublayer(pulsatingLayer)
        
        // Create track layer
        layer.addSublayer(createCircleShapeLayer(path: circularPath.cgPath,
                                                 strokeColor: #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1),
                                                 fillColor: .clear,
                                                 center: center))
        
        layer.addSublayer(createTextLayer(textColor: #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)))
    }
    
    private func animatePulsingLayer() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        animation.toValue = 1.1
        animation.duration = 0.5
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        
        pulsatingLayer?.add(animation, forKey: "pulsing")
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
        let path = UIBezierPath(arcCenter: .zero, radius: radius ?? 65, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        return path.cgPath
    }
    
    private func createTextLayer(textColor: UIColor) -> CATextLayer {
        
        let width = frame.size.width
        let height = frame.size.height
                
        let layer = CATextLayer()
        
        var fontSize: CGFloat = 32.0
        
        let expenseSavingAbs: CGFloat = abs(expensesSavingsTotal ?? absTotal!)
        
        if expenseSavingAbs > 1000000000000 {
            layer.string = "error"
        } else if expenseSavingAbs > 10000000000 {
            fontSize = 12.0
        } else if expenseSavingAbs > 1000000000 {
            fontSize = 14.0
        } else if expenseSavingAbs > 100000000 {
            fontSize = 16.0
        } else if expenseSavingAbs > 10000000 {
            fontSize = 20.0
        } else if expenseSavingAbs > 1000000 {
            fontSize = 24.0
        } else if expenseSavingAbs > 100000 {
            fontSize = 28.0
        } else if expenseSavingAbs > 10000 {
            fontSize = 32.0
        }
        
        layer.string = "\(Int(expensesSavingsTotal ?? absTotal!))"
        layer.backgroundColor = UIColor.clear.cgColor
        layer.foregroundColor = textColor.cgColor
        layer.font = UIFont(name: "AmericanTypewriter-Bold", size: fontSize)
        layer.fontSize = fontSize
        layer.frame = CGRect(x: 0, y: (height - fontSize) / 2 - 4, width: width, height: height)
        layer.alignmentMode = .center
        
        return layer
      }
    
    @objc private func handleEnterForeground() {
        animatePulsingLayer()
    }
    
    @objc private func handleTap() {
        
        for layer in circleLayers {
            let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
            basicAnimation.fromValue = 0.01
            
            basicAnimation.duration = 2.0
            basicAnimation.fillMode = CAMediaTimingFillMode.forwards
            basicAnimation.isRemovedOnCompletion = false
            basicAnimation.toValue = 0.99
            
            layer.strokeEnd = 1.0
            layer.add(basicAnimation, forKey: "urSoBasic")
        }
    
        animatePulsingLayer()
    }
    
    private func addGradient(path: CirclePath, total: CGFloat, circleLayer: CAShapeLayer) {
        let gradient = CAGradientLayer()
        
        let startAngle = path.startAngle!
        let endAngle = path.startAngle! + 2 * CGFloat.pi * (path.data / total)
        
        gradient.startPoint = transformPoint(point: CGPoint(x: sin(startAngle), y: cos(startAngle)))
        gradient.endPoint = transformPoint(point: CGPoint(x: sin(endAngle), y: cos(endAngle)))
            
        gradient.locations = [0.0, 1.0]
        
        guard let category = path.category else { return }
        let colors = category.getColors(category: category)
        
        gradient.colors = [colors.0.cgColor, colors.1.cgColor]
        
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
