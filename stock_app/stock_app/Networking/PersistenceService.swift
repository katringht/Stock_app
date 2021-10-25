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
    
    func cart(s: String, ln: String, count: Int, myPice: Double ,rMP: Double, rMPL: Double, rMPH: Double, wL: Double, wH: Double) -> Cart {
        let cart = Cart(context: persistentContainer.viewContext)
        cart.longName = ln
        cart.symbol = s
        cart.regularMarketPrice = rMP
        cart.regularMarketDayLow = rMPL
        cart.regularMarketDayHigh = rMPH
        cart.fiftyTwoWeekLow = wL
        cart.fiftyTwoWeekHigh = wH
        cart.myPrice = myPice
        cart.stockscount = Int32(count)
        return cart
    }
    
    func fetchRequestCart() -> [Cart] {
        let request: NSFetchRequest<Cart> = Cart.fetchRequest()
        var fetchedMyCart: [Cart] = []
        
        do {
            fetchedMyCart = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching")
        }
        return fetchedMyCart
    }
}
