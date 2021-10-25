//
//  RoundDouble.swift
//  stock_app
//
//  Created by Ekaterina Tarasova on 25.10.2021.
//

import Foundation

func roundDouble(_ value: Double, toDecimalPlaces places: Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return round(value * divisor) / divisor
}
