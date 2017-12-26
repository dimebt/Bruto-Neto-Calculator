//
//  UIButtonCircleWithArrow.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 12/26/17.
//  Copyright © 2017 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class UIButtonCircleWithArrow: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        
        let shadowLayer = CAShapeLayer()
        shadowLayer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: self.frame.height / 2).cgPath
        shadowLayer.shadowOffset = CGSize(width: 0, height: 2)
        shadowLayer.shadowColor = UIColor.init(hex: "000000").withAlphaComponent(0.3).cgColor
        shadowLayer.shadowRadius = 4
        shadowLayer.shadowOpacity = 1
        
        
        let circleLayer = CAShapeLayer()
        circleLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: self.frame.height / 2).cgPath
        let frameLayer = CAShapeLayer()
        
        let path = UIBezierPath(rect: bounds.insetBy(dx: -10, dy: -10))
        path.append(UIBezierPath(roundedRect: bounds, cornerRadius: self.frame.height / 2))
        
        frameLayer.path = path.cgPath
        
        frameLayer.fillRule = kCAFillRuleEvenOdd
        frameLayer.backgroundColor = UIColor.red.cgColor
        frameLayer.mask = circleLayer

        shadowLayer.mask = frameLayer
        self.layer.insertSublayer(shadowLayer, at: 0)
        
        // Background layer
        let backgroundLayer = CAGradientLayer()
        backgroundLayer.frame = bounds
        backgroundLayer.colors = [UIColor.init(hex: ButtonColors.GradientBackgroundDark).withAlphaComponent(0.3).cgColor, UIColor.clear.cgColor]
        backgroundLayer.locations = [0.0, 1.0]
        backgroundLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        backgroundLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        backgroundLayer.needsDisplayOnBoundsChange = true
        backgroundLayer.name = "GradientLayer"
        backgroundLayer.mask = circleLayer
        self.layer.insertSublayer(backgroundLayer, at: 1)

        
        // Arrow Shape
        let arrow = CAShapeLayer()
        let arrowPath = UIBezierPath()
        let lineWidth: CGFloat = 3
        let startPoint = CGPoint(x: frame.width / 5, y: frame.height / 1.5)
        let middleUp = CGPoint(x: frame.width / 2, y: frame.height / 3)
        let endPoint = CGPoint(x: frame.width - (frame.width / 5), y: frame.height / 1.5)
        let endPointLeft = CGPoint(x: frame.width - (frame.width / 5) - lineWidth, y: frame.height / 1.5)
        let middleUpDown = CGPoint(x: frame.width / 2, y: (frame.height / 3) + lineWidth)
        let startPointRight = CGPoint(x: (frame.width / 5) + lineWidth, y: frame.height / 1.5)
        arrowPath.move(to: startPoint)
        arrowPath.addLine(to: middleUp)
        arrowPath.addLine(to: endPoint)
        arrowPath.addLine(to: endPointLeft)
        arrowPath.addLine(to: middleUpDown)
        arrowPath.addLine(to: startPointRight)
        arrowPath.close()
        arrow.path = arrowPath.cgPath
        arrow.fillColor = UIColor.init(hex: ButtonColors.GreenLine).cgColor
        
        self.layer.addSublayer(arrow)
        
        
    }

}
