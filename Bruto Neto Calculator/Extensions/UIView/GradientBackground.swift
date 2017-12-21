//
//  GradientBackground.swift
//  MyGym
//
//  Created by Dimitar Stefanovski on 08.18.2017.
//  Copyright © 2017 Dimitar Stefanovski. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    @objc func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
