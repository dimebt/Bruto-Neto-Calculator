//
//  CalculationModel.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 2/7/18.
//  Copyright © 2018 Dimitar Stefanovski. All rights reserved.
//

import Foundation

struct CalculationModel {
    var year: Int
    var bruto: Double
    var neto: Double
    var personalIncomeTax: Double
    var pensionAndDisabilityInsurance: Double
    var healthInsuranceFund: Double
    var additionalHealthInsuranceAndPersonalInjuryInsurance: Double
    var unemploymentInsuranceFund: Double
    var sumInsuranceFunds: Double
    var sumInsurancePlusPersonalIncomeTax: Double
    
    init() {
        self.year = 0
        self.bruto = 0
        self.neto = 0
        self.personalIncomeTax = 0
        self.pensionAndDisabilityInsurance = 0
        self.healthInsuranceFund = 0
        self.additionalHealthInsuranceAndPersonalInjuryInsurance = 0
        self.unemploymentInsuranceFund = 0
        self.sumInsuranceFunds = 0
        self.sumInsurancePlusPersonalIncomeTax = 0
    }
}
