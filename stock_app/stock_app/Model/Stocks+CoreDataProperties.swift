//
//  Stocks+CoreDataProperties.swift
//  stock_app
//
//  Created by Ekaterina Tarasova on 09.08.2021.
//
//

import Foundation
import CoreData


extension Stocks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stocks> {
        return NSFetchRequest<Stocks>(entityName: "Stocks")
    }

    @NSManaged public var symbol: String?
    @NSManaged public var longName: String?
    @NSManaged public var regularMarketPrice: Double
    @NSManaged public var regularMarketDayHigh: Double
    @NSManaged public var regularMarketDayLow: Double
    @NSManaged public var fiftyTwoWeekLow: Double
    @NSManaged public var fiftyTwoWeekHigh: Double

}

extension Stocks : Identifiable {

}
