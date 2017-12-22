//
//  UIButtonNumpad.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 12/22/17.
//  Copyright © 2017 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class UIButtonNumpad: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private var backgroundLayer: CAShapeLayer!
    
    private func setup() {
        self.addTarget(self, action: #selector(UIButtonNumpad.touchDown), for: UIControlEvents.touchDown)
        self.addTarget(self, action: #selector(UIButtonNumpad.touchUpInside), for: UIControlEvents.touchUpInside)
        
        self.backgroundLayer = CAShapeLayer()
        self.backgroundLayer.frame = CGRect(x: 0, y: 0, width: self.frame.height, height: self.frame.height)
        let centerX = (self.frame.width - self.frame.height) / 2
        let centerY = self.frame.width - self.frame.height
        self.backgroundLayer.frame.origin = CGPoint(x: centerX, y: centerY)
        self.backgroundLayer.cornerRadius = self.frame.height / 2
        self.backgroundLayer.masksToBounds = true
        self.backgroundLayer.backgroundColor = UIColor.clear.cgColor
        self.layer.insertSublayer(self.backgroundLayer, at: 0)
    }
    
    @objc private func touchDown() {
        self.backgroundLayer.backgroundColor = UIColor.init(hex: ButtonColors.Background).cgColor
    }
    @objc private func touchUpInside() {
         self.backgroundLayer.backgroundColor = UIColor.clear.cgColor
    }

}
