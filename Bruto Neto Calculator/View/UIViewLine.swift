//
//  UIViewLine.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 12/26/17.
//  Copyright © 2017 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class UIViewLine: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }

    private func setup() {
        
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowColor = UIColor.init(hex: "FFFFFF").withAlphaComponent(0.4).cgColor
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 1
        
    }

}
