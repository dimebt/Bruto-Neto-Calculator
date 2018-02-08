//
//  Input.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 2/8/18.
//  Copyright © 2018 Dimitar Stefanovski. All rights reserved.
//

import Foundation

class InputParameters {
    public var year: Int
    public var calculationType: CalculationType
    public var value: Double
    
    init(year: Int, calculationType: CalculationType, value: Double) {
        self.year = year
        self.calculationType = calculationType
        self.value = value
    }
    
    init() {
        self.year = 2018
        self.calculationType = CalculationType.bruto
        self.value = 0
    }
}
