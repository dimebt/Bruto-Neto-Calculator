//
//  Currencies.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 2/13/18.
//  Copyright © 2018 Dimitar Stefanovski. All rights reserved.
//

import Foundation

struct Curencies {
    static let database: [Currency] = [
        Currency(code: "MKD", symbol: "ден.", rate: 1),
        Currency(code: "EUR", symbol: "€", rate: 61.7),
        Currency(code: "USD", symbol: "$", rate: 50.2),
        Currency(code: "GBP", symbol: "£", rate: 69.5),
        Currency(code: "SEK", symbol: "kr.", rate: 6.2),
        Currency(code: "CHF", symbol: "CHF", rate: 53.6),
        Currency(code: "DKK", symbol: "kr.", rate: 8.28),
        Currency(code: "CAD", symbol: "$", rate: 39.96),
        Currency(code: "AUD", symbol: "$", rate: 39.41)
    ]
}
