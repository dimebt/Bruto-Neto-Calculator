//
//  UIViewSideMenu.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 1/9/18.
//  Copyright © 2018 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class UIViewSideMenu: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
    }
    
    func dropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 5, height: 0)
        self.layer.shadowRadius = 5
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    override func draw(_ rect: CGRect) {
        dropShadow()
    }
    
    override func layoutSubviews() {
        dropShadow()
    }

  
}
