//
//  UIButtonBrutoType1.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 12/22/17.
//  Copyright © 2017 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class UIButtonBrutoType1: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
        self.addTarget(self, action: #selector(UIButtonBrutoType1.onPress), for: .touchUpInside)
    }
    
    @objc private func onPress() {
        self.backgroundColor = UIColor.init(hex: ButtonColors.Background)        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height / 2
    }


}
