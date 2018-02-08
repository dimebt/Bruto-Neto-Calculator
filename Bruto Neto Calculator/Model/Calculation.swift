//
//  Calculation.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 2/7/18.
//  Copyright © 2018 Dimitar Stefanovski. All rights reserved.
//

import Foundation

class Calcualtion {
    
    public var calculation: CalculationModel = CalculationModel()
    
    init(for value: Double, calculationType: CalculationType, year: Int) {
        switch calculationType {
        case .bruto:
            print("bruto calculation")
            let pensionAndDisabilityInsurance = value * YearParameters.param2018.pensionAndDisabilityInsuranceRate
            let healthInsuranceFund = value * YearParameters.param2018.healthInsuranceFundRate
            let additionalHealthInsuranceAndPersonalInjuryInsurance = value * YearParameters.param2018.additionalHealthInsuranceAndPersonalInjuryInsuranceRate
            let unemploymentInsuranceFund = value * YearParameters.param2018.unemploymentInsuranceFundRate
            calculation.pensionAndDisabilityInsurance = pensionAndDisabilityInsurance
            calculation.healthInsuranceFund = healthInsuranceFund
            calculation.additionalHealthInsuranceAndPersonalInjuryInsurance = additionalHealthInsuranceAndPersonalInjuryInsurance
            calculation.unemploymentInsuranceFund = unemploymentInsuranceFund
            let sumInsuranceFunds = pensionAndDisabilityInsurance + healthInsuranceFund + additionalHealthInsuranceAndPersonalInjuryInsurance + unemploymentInsuranceFund
            calculation.sumInsuranceFunds = sumInsuranceFunds
            let personalIncomeTax = (value - (sumInsuranceFunds + YearParameters.param2018.personalIncomeTaxExemptionPerMonth)) * YearParameters.param2018.personalIncomeTaxRate
            calculation.personalIncomeTax = personalIncomeTax
            let sumInsurancePlusPersonalIncomeTax = sumInsuranceFunds + personalIncomeTax
            calculation.sumInsurancePlusPersonalIncomeTax = sumInsurancePlusPersonalIncomeTax
            calculation.bruto = value
            calculation.neto = value - sumInsurancePlusPersonalIncomeTax            
        case .neto:
            print("neto calculation")
            let sumInsuranceRates = YearParameters.param2018.pensionAndDisabilityInsuranceRate +
            YearParameters.param2018.healthInsuranceFundRate +
            YearParameters.param2018.additionalHealthInsuranceAndPersonalInjuryInsuranceRate +
            YearParameters.param2018.unemploymentInsuranceFundRate
            let netoToBrutoRate = 1 - sumInsuranceRates - ( 1 - sumInsuranceRates) * YearParameters.param2018.personalIncomeTaxRate
            let bruto = (value - (YearParameters.param2018.personalIncomeTaxExemptionPerMonth / 10)) / netoToBrutoRate
            print(bruto)
        }
    }
    
    
}

enum CalculationType {
    case bruto
    case neto
}
