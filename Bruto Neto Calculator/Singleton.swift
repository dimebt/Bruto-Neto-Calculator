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
