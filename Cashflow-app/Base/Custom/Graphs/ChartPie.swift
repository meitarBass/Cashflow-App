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

class ChartPie: UIView {
    
    let appearance = Appearance()
    
    private var colors: [UIColor]?
    private var pulsatingColor: UIColor?
    private var circleLayer: CAShapeLayer!
    private var pulsatingLayer: CAShapeLayer!
    private var textLayer: CATextLayer!
    
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
        pulsatingLayer = createCircleShapeLayer(strokeColor: pulsatingColor,
                                                fillColor: .clear, center: center)
        let trackLayer = createCircleShapeLayer(strokeColor: #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1), fillColor: .white, center: center)
        circleLayer = createCircleShapeLayer(strokeColor: .white, fillColor: .clear, center: center)

        textLayer = createTextLayer(textColor: .black)
        
        layer.addSublayer(pulsatingLayer)
        layer.addSublayer(trackLayer)
        self.addGradient()
        layer.addSublayer(textLayer)
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
    
    private func createCircleShapeLayer(strokeColor: UIColor, fillColor: UIColor, center: CGPoint) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.fillColor = fillColor.cgColor
        layer.lineWidth = 10.0
        layer.lineCap = CAShapeLayerLineCap.round
        layer.position = center
        layer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        
        return layer
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
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.fromValue = 0.0
        
        basicAnimation.duration = 2.0
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.toValue = 1.0
        
        circleLayer.strokeEnd = 1.0
        circleLayer.add(basicAnimation, forKey: "urSoBasic")
        
        animatePulsingLayer()
    }
    
    func addGradient() {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.5)
        
        gradient.locations = [0.0, 1.0]
        
        guard let colors = self.colors else { return }
        let fromColor = colors[0]
        let toColor = colors[1]
        
        gradient.colors = [fromColor.cgColor, toColor.cgColor]
        gradient.frame = bounds
        gradient.mask = circleLayer
        
        layer.addSublayer(gradient)
    }
}
