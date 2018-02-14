//
//  Singleton.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 2/13/18.
//  Copyright © 2018 Dimitar Stefanovski. All rights reserved.
//

import Foundation


class CalculationResults {
    
    static let shared = CalculationResults()
    private var calculationModel = CalculationModel()
    
    private init() { }
    
    func getParameters() -> CalculationModel {
        return calculationModel
    }
    
    func setParameters(with calculationModel: CalculationModel) {
        self.calculationModel = calculationModel
    }
    
    
}

class CurrencySelector {
    static let sharedInstance = CurrencySelector()
    private var currency: Currency = Currency(code: "MKD", symbol: "ден.", rate: 1)
    
    private init() { }
    
    func getCurrency() -> Currency {
        return self.currency
    }
    
    func setCurrency(currency: Currency) {
        self.currency = currency
    }
}
