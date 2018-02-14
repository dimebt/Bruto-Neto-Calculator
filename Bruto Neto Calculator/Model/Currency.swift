//
//  Currency.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 2/9/18.
//  Copyright © 2018 Dimitar Stefanovski. All rights reserved.
//

import Foundation

struct Currency {
    let code: String
    let symbol: String
    let rate: Double
    
    init(code: String, symbol: String, rate: Double) {
        self.code = code
        self.symbol = symbol
        self.rate = rate
    }
}
