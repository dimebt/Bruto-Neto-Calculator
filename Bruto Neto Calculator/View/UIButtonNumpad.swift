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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundLayer.frame = CGRect(x: 0, y: 0, width: self.frame.height, height: self.frame.height)
        self.backgroundLayer.cornerRadius = self.bounds.height / 2
        self.backgroundLayer.position = CGPoint.init(x: self.bounds.midX , y: self.bounds.midY)
        self.backgroundLayer.masksToBounds = true
    }
    
    private var backgroundLayer: CAShapeLayer!
    
    private func setup() {
        self.addTarget(self, action: #selector(UIButtonNumpad.touchDown), for: .touchDown)
        self.addTarget(self, action: #selector(UIButtonNumpad.touchUpInside), for: .touchUpInside)
        self.addTarget(self, action: #selector(UIButtonNumpad.touchDragExit), for: .touchDragExit)
        
        self.backgroundLayer = CAShapeLayer()
        self.backgroundLayer.backgroundColor = UIColor.clear.cgColor
        self.layer.insertSublayer(self.backgroundLayer, at: 0)
    }
    
    @objc private func touchDown() {
        self.backgroundLayer.backgroundColor = UIColor.init(hex: ButtonColors.Background).cgColor
    }
    @objc private func touchUpInside() {
         self.backgroundLayer.backgroundColor = UIColor.clear.cgColor
    }
    @objc private func touchDragExit() {
        self.backgroundLayer.backgroundColor = UIColor.clear.cgColor
    }

}
