//
//  Stock.swift
//  stock_app
//
//  Created by Ekaterina Tarasova on 12.08.2021.
//

import Foundation

struct StockQuotes: Codable {
    var quotes: [Stock]
}

struct Stock: Codable {
    var symbol: String
    var longName: String
    var regularMarketPrice: Double
    var regularMarketDayHigh: Double
    var regularMarketDayLow: Double
    var fiftyTwoWeekHigh: Double
    var fiftyTwoWeekLow: Double
}
