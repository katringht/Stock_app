//
//  Stock.swift
//  stock_app
//
//  Created by Ekaterina Tarasova on 11.03.2021.
//

import Foundation

struct Stock: Codable {
    var symbol: String
    var longName: String
    var regularMarketPrice: Double
    var regularMarketDayRange: String
    
}
