//
//  Parameters.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 2/2/18.
//  Copyright © 2018 Dimitar Stefanovski. All rights reserved.
//

import Foundation

struct Parameters {
    // MK Translation
    /*
     
     Година
     - Стапки
     Персонален данок на доход од плата
     Пензиско и инвалидско осигурување
     Здравствено осигурување
     Допилнително здравствено осигурување
     Осигурување во случај на невработеност
     
     Даночно лично ослободување
     Просечна месечна плата
     
     */   
    
    var year: Int
    var personalIncomeTaxRate: Double
    var pensionAndDisabilityInsuranceRate: Double
    var healthInsuranceFundRate: Double
    var additionalHealthInsuranceAndPersonalInjuryInsuranceRate: Double
    var unemploymentInsuranceFundRate: Double
    
    var personalIncomeTaxExemptionPerMonth: Double
    var averageSalary: Double
    
    init(year: Int,
         personalIncomeTaxRate: Double,
         pensionAndDisabilityInsuranceRate: Double,
         healthInsuranceFundRate: Double,
         additionalHealthInsuranceAndPersonalInjuryInsuranceRate: Double,
         unemploymentInsuranceFundRate: Double,
         personalIncomeTaxExemptionPerMonth: Double,
         averageSalary: Double) {
        self.year = year
        self.personalIncomeTaxRate = personalIncomeTaxRate
        self.pensionAndDisabilityInsuranceRate = pensionAndDisabilityInsuranceRate
        self.healthInsuranceFundRate = healthInsuranceFundRate
        self.additionalHealthInsuranceAndPersonalInjuryInsuranceRate = additionalHealthInsuranceAndPersonalInjuryInsuranceRate
        self.unemploymentInsuranceFundRate = unemploymentInsuranceFundRate
        self.personalIncomeTaxExemptionPerMonth = personalIncomeTaxExemptionPerMonth
        self.averageSalary = averageSalary
    }
    
}
