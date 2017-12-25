//
//  Double.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 12/25/17.
//  Copyright © 2017 Dimitar Stefanovski. All rights reserved.
//

import Foundation

extension Decimal {
    var significantFractionalDecimalDigits: Int {
        return max(-exponent, 0)
    }
}
