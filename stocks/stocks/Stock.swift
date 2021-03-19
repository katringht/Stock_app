//
//  Stock.swift
//  stocks
//
//  Created by Ekaterina Tarasova on 19.03.2021.
//

import SwiftUI

//MARK: API

struct StocksApi: Codable {
    var quotes: [Stock]
}

struct Stock: Codable, Hashable{
    var sharesOutstanding: Int
    var symbol: String
    var longName: String
    var regularMarketPrice: Double
    var regularMarketDayRange: String

}


