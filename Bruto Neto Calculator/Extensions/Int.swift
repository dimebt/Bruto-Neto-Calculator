//
//  File.swift
//  Bruto Neto Calculator
//
//  Created by Dimitar Stefanovski on 1/30/18.
//  Copyright © 2018 Dimitar Stefanovski. All rights reserved.
//

import Foundation

extension Int {
    func DegreesToRadians() -> Double {
        return ((Double(self) * Double.pi) / 180)
    }
}
