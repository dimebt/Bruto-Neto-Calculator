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
    public var status: String = "OK"
    private var parameters: Parameters = Parameters()
    
    
    init(for value: Double, calculationType: CalculationType, year: Int, currency: Currency) {
        
        
        // Get parameters for years
        for parameters in YearParameters.parameters {
            if (parameters.year == year) {
                self.parameters.year = parameters.year
                self.parameters.pensionAndDisabilityInsuranceRate = parameters.pensionAndDisabilityInsuranceRate
                self.parameters.additionalHealthInsuranceAndPersonalInjuryInsuranceRate = parameters.additionalHealthInsuranceAndPersonalInjuryInsuranceRate
                self.parameters.unemploymentInsuranceFundRate = parameters.unemploymentInsuranceFundRate
                self.parameters.healthInsuranceFundRate = parameters.healthInsuranceFundRate
                self.parameters.personalIncomeTaxRate = parameters.personalIncomeTaxRate
                self.parameters.averageSalary = parameters.averageSalary
                self.parameters.personalIncomeTaxExemptionPerMonth = parameters.personalIncomeTaxExemptionPerMonth
            }
        }
        
        //print(self.parameters)
        
        /*
         check currency if MKD
         if != MKD
         convert to MKD
         from MKD -> Currency
        */
        var value = value
        var toCurrencyRate: Double = 1
        if (currency.code != "MKD") {
            value = currency.rate * value
            toCurrencyRate = 1 / currency.rate
        }
        
        
        switch calculationType {
        case .bruto:
            print("bruto calculation")
            
            let highestValue = 12 * self.parameters.averageSalary
            let inputValue = value
            var value = value
            if (value > highestValue) {
                value = highestValue
            }
            
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
            let personalIncomeTax = ((inputValue - (sumInsuranceFunds + self.parameters.personalIncomeTaxExemptionPerMonth)) * self.parameters.personalIncomeTaxRate).rounded(.toNearestOrAwayFromZero)
            results.personalIncomeTax = personalIncomeTax
            let sumInsurancePlusPersonalIncomeTax = (sumInsuranceFunds + personalIncomeTax).rounded(.toNearestOrAwayFromZero)
            results.sumInsurancePlusPersonalIncomeTax = sumInsurancePlusPersonalIncomeTax
            results.bruto = inputValue
            results.neto = inputValue - sumInsurancePlusPersonalIncomeTax
            let mainBrutoValue = self.parameters.averageSalary * 0.5
            if mainBrutoValue > value {
                self.status = "LowValue"
            } else {
                self.status = "OK"
            }
            
            // convert back to input currency
            results.pensionAndDisabilityInsurance = pensionAndDisabilityInsurance * toCurrencyRate
            results.healthInsuranceFund = healthInsuranceFund * toCurrencyRate
            results.additionalHealthInsuranceAndPersonalInjuryInsurance = additionalHealthInsuranceAndPersonalInjuryInsurance * toCurrencyRate
            results.unemploymentInsuranceFund = unemploymentInsuranceFund * toCurrencyRate
            results.sumInsuranceFunds = sumInsuranceFunds * toCurrencyRate
            results.personalIncomeTax = personalIncomeTax * toCurrencyRate
            results.sumInsurancePlusPersonalIncomeTax = sumInsurancePlusPersonalIncomeTax * toCurrencyRate
            results.bruto = inputValue  * toCurrencyRate
            results.neto = (inputValue - sumInsurancePlusPersonalIncomeTax) * toCurrencyRate
            
        case .neto:
            print("neto calculation")
            let sumInsuranceRates = self.parameters.pensionAndDisabilityInsuranceRate +
            self.parameters.healthInsuranceFundRate +
            self.parameters.additionalHealthInsuranceAndPersonalInjuryInsuranceRate +
            self.parameters.unemploymentInsuranceFundRate
            let netoToBrutoRate = 1 - sumInsuranceRates - ( 1 - sumInsuranceRates) * self.parameters.personalIncomeTaxRate
            var bruto = ((value - (self.parameters.personalIncomeTaxExemptionPerMonth / 10)) / netoToBrutoRate).rounded(.toNearestOrAwayFromZero)
            
            let highestValue = 12 * self.parameters.averageSalary
            let inputValue = bruto
            if (bruto > highestValue) {
                bruto = highestValue
            }
            
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
            let personalIncomeTax = ((inputValue - (sumInsuranceFunds + self.parameters.personalIncomeTaxExemptionPerMonth)) * self.parameters.personalIncomeTaxRate).rounded(.toNearestOrAwayFromZero)
            results.personalIncomeTax = personalIncomeTax
            let sumInsurancePlusPersonalIncomeTax = (sumInsuranceFunds + personalIncomeTax).rounded(.toNearestOrAwayFromZero)
            results.sumInsurancePlusPersonalIncomeTax = sumInsurancePlusPersonalIncomeTax
            results.bruto = inputValue
            results.neto = value
            //results.neto = bruto - sumInsurancePlusPersonalIncomeTax
            
            if (self.parameters.averageSalary * 0.5) > bruto {
                self.status = "LowValue"
            } else {
                self.status = "OK"
            }
            
            // convert back to input currency
            results.pensionAndDisabilityInsurance = pensionAndDisabilityInsurance * toCurrencyRate
            results.healthInsuranceFund = healthInsuranceFund * toCurrencyRate
            results.additionalHealthInsuranceAndPersonalInjuryInsurance = additionalHealthInsuranceAndPersonalInjuryInsurance * toCurrencyRate
            results.unemploymentInsuranceFund = unemploymentInsuranceFund * toCurrencyRate
            results.sumInsuranceFunds = sumInsuranceFunds * toCurrencyRate
            results.personalIncomeTax = personalIncomeTax * toCurrencyRate
            results.sumInsurancePlusPersonalIncomeTax = sumInsurancePlusPersonalIncomeTax * toCurrencyRate
            results.bruto = inputValue * toCurrencyRate
            results.neto = value * toCurrencyRate
            
        }
    }
    
    
}

enum CalculationType {
    case bruto
    case neto
}
