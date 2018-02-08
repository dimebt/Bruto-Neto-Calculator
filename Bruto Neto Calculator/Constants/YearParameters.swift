//
//  YearParameters.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 2/7/18.
//  Copyright © 2018 Dimitar Stefanovski. All rights reserved.
//

import Foundation

struct YearParameters {
    static let parameters: [Parameters] =
        [
            Parameters(year: 2018,
                       personalIncomeTaxRate: 0.1,
                       pensionAndDisabilityInsuranceRate: 0.18,
                       healthInsuranceFundRate: 0.073,
                       additionalHealthInsuranceAndPersonalInjuryInsuranceRate: 0.005,
                       unemploymentInsuranceFundRate: 0.012,
                       personalIncomeTaxExemptionPerMonth: 7531,
                       averageSalary: 34079),
            Parameters(year: 2017,
                       personalIncomeTaxRate: 0.1,
                       pensionAndDisabilityInsuranceRate: 0.18,
                       healthInsuranceFundRate: 0.073,
                       additionalHealthInsuranceAndPersonalInjuryInsuranceRate: 0.005,
                       unemploymentInsuranceFundRate: 0.012,
                       personalIncomeTaxExemptionPerMonth: 7531,
                       averageSalary: 34079)
    ]
}

