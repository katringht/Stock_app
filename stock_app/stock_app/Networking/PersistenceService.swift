//
//  PersistenceService.swift
//  stock_app
//
//  Created by Ekaterina Tarasova on 09.08.2021.
//

import Foundation
import CoreData

class PersistenceService {
    static let shared = PersistenceService()
    private init() {}
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "stock_app")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func stock(symbol: String, longName: String, price: Double) -> Stocks{
        let stc = Stocks(context: persistentContainer.viewContext)
        stc.symbol = symbol
        stc.longName = longName
        stc.regularMarketPrice = price
        return stc
    }
    //fetching data
        
    func fetchRequest() -> [Stocks] {
        let request: NSFetchRequest<Stocks> = Stocks.fetchRequest()
        var fetchedMyCategiries: [Stocks] = []
        
        do {
            fetchedMyCategiries = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching")
        }
        return fetchedMyCategiries
    }

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
