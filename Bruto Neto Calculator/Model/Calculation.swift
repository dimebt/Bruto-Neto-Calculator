//
//  Calculation.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 2/7/18.
//  Copyright © 2018 Dimitar Stefanovski. All rights reserved.
//

import Foundation

class Calcualtion {
    
    public var results: CalculationModel = CalculationModel()
    private var parameters: Parameters!
    
    init(for value: Double, calculationType: CalculationType, year: Int) {
        
        
        // Get parameters for years
        for parameters in YearParameters.parameters {
            if (parameters.year == year) {
                self.parameters = parameters
            }
        }
        
        switch calculationType {
        case .bruto:
            print("bruto calculation")
            let pensionAndDisabilityInsurance = (value * self.parameters.pensionAndDisabilityInsuranceRate).rounded(.toNearestOrAwayFromZero)
            let healthInsuranceFund = (value * self.parameters.healthInsuranceFundRate).rounded(.toNearestOrAwayFromZero)
            let additionalHealthInsuranceAndPersonalInjuryInsurance = (value * self.parameters.additionalHealthInsuranceAndPersonalInjuryInsuranceRate).rounded(.toNearestOrAwayFromZero)
            let unemploymentInsuranceFund = (value * self.parameters.unemploymentInsuranceFundRate).rounded(.toNearestOrAwayFromZero)
            results.pensionAndDisabilityInsurance = pensionAndDisabilityInsurance
            results.healthInsuranceFund = healthInsuranceFund
            results.additionalHealthInsuranceAndPersonalInjuryInsurance = additionalHealthInsuranceAndPersonalInjuryInsurance
            results.unemploymentInsuranceFund = unemploymentInsuranceFund
            let sumInsuranceFunds = (pensionAndDisabilityInsurance + healthInsuranceFund + additionalHealthInsuranceAndPersonalInjuryInsurance + unemploymentInsuranceFund).rounded(.toNearestOrAwayFromZero)
            results.sumInsuranceFunds = sumInsuranceFunds
            let personalIncomeTax = ((value - (sumInsuranceFunds + self.parameters.personalIncomeTaxExemptionPerMonth)) * self.parameters.personalIncomeTaxRate).rounded(.toNearestOrAwayFromZero)
            results.personalIncomeTax = personalIncomeTax
            let sumInsurancePlusPersonalIncomeTax = (sumInsuranceFunds + personalIncomeTax).rounded(.toNearestOrAwayFromZero)
            results.sumInsurancePlusPersonalIncomeTax = sumInsurancePlusPersonalIncomeTax
            results.bruto = value
            results.neto = value - sumInsurancePlusPersonalIncomeTax
        case .neto:
            print("neto calculation")
            let sumInsuranceRates = self.parameters.pensionAndDisabilityInsuranceRate +
            self.parameters.healthInsuranceFundRate +
            self.parameters.additionalHealthInsuranceAndPersonalInjuryInsuranceRate +
            self.parameters.unemploymentInsuranceFundRate
            let netoToBrutoRate = 1 - sumInsuranceRates - ( 1 - sumInsuranceRates) * self.parameters.personalIncomeTaxRate
            let bruto = ((value - (self.parameters.personalIncomeTaxExemptionPerMonth / 10)) / netoToBrutoRate).rounded(.toNearestOrAwayFromZero)
            
            // Repetitive code
            let pensionAndDisabilityInsurance = (bruto * self.parameters.pensionAndDisabilityInsuranceRate).rounded(.toNearestOrAwayFromZero)
            let healthInsuranceFund = (bruto * self.parameters.healthInsuranceFundRate).rounded(.toNearestOrAwayFromZero)
            let additionalHealthInsuranceAndPersonalInjuryInsurance = (bruto * self.parameters.additionalHealthInsuranceAndPersonalInjuryInsuranceRate).rounded(.toNearestOrAwayFromZero)
            let unemploymentInsuranceFund = (bruto * self.parameters.unemploymentInsuranceFundRate).rounded(.toNearestOrAwayFromZero)
            results.pensionAndDisabilityInsurance = pensionAndDisabilityInsurance
            results.healthInsuranceFund = healthInsuranceFund
            results.additionalHealthInsuranceAndPersonalInjuryInsurance = additionalHealthInsuranceAndPersonalInjuryInsurance
            results.unemploymentInsuranceFund = unemploymentInsuranceFund
            let sumInsuranceFunds = (pensionAndDisabilityInsurance + healthInsuranceFund + additionalHealthInsuranceAndPersonalInjuryInsurance + unemploymentInsuranceFund).rounded(.toNearestOrAwayFromZero)
            results.sumInsuranceFunds = sumInsuranceFunds
            let personalIncomeTax = ((bruto - (sumInsuranceFunds + self.parameters.personalIncomeTaxExemptionPerMonth)) * self.parameters.personalIncomeTaxRate).rounded(.toNearestOrAwayFromZero)
            results.personalIncomeTax = personalIncomeTax
            let sumInsurancePlusPersonalIncomeTax = (sumInsuranceFunds + personalIncomeTax).rounded(.toNearestOrAwayFromZero)
            results.sumInsurancePlusPersonalIncomeTax = sumInsurancePlusPersonalIncomeTax
            results.bruto = bruto
            results.neto = bruto - sumInsurancePlusPersonalIncomeTax
        }
    }
    
    
}

enum CalculationType {
    case bruto
    case neto
}
