//
//  Stock.swift
//  stock_app
//
//  Created by Ekaterina Tarasova on 09.03.2021.
//

import Foundation

struct Stock: Codable {
    var symbol: String
    var longName: String
    var regularMarketPrice: String
    var regularMarketDayRange: String
    
}
