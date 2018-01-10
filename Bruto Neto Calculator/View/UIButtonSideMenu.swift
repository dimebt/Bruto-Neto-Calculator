//
//  UIButtonSideMenu.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 1/10/18.
//  Copyright © 2018 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class UIButtonSideMenu: UIButton {

    let line1 = CALayer()
    let line2 = CALayer()
    let line3 = CALayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        
        let lineHeight = frame.height / 6
        
        line1.frame = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width, height: lineHeight)
        line1.backgroundColor = UIColor.init(hex: ButtonColors.SideMenuLine).withAlphaComponent(0.3).cgColor
        self.layer.addSublayer(line1)
        
        line2.frame = CGRect(x: bounds.origin.x, y: bounds.origin.y + 2 * lineHeight, width: bounds.width, height: lineHeight)
        line2.backgroundColor = UIColor.init(hex: ButtonColors.SideMenuLine).withAlphaComponent(0.3).cgColor
        self.layer.addSublayer(line2)
        
        line3.frame = CGRect(x: bounds.origin.x, y: bounds.origin.y + 4 * lineHeight, width: bounds.width, height: lineHeight)
        line3.backgroundColor = UIColor.init(hex: ButtonColors.SideMenuLine).withAlphaComponent(0.3).cgColor
        self.layer.addSublayer(line3)
        
    }
    
  
}
