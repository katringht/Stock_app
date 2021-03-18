//
//  Stock.swift
//  stocks
//
//  Created by Ekaterina Tarasova on 18.03.2021.
//

import Foundation

struct Stock: Codable, Hashable  {
    var symbol: String
    var longName: String
    var regularMarketPrice: Double
    var regularMarketDayRange: String
    
}
