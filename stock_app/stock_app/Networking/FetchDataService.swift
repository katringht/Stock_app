//
//  FetchDataService.swift
//  stock_app
//
//  Created by Ekaterina Tarasova on 23.10.2021.
//

import UIKit
import CoreData

// fetch and update data base

class FetchDataService {
    
    lazy var fetchedResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Stocks.self))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "symbol", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: PersistenceService.shared.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }()
    
    func updateView(_ vc: UIViewController)  {
        do {
            try fetchedResultController.performFetch()
            print("COUNT FETCHED FIRST: \(String(describing: fetchedResultController.sections?[0].numberOfObjects))")
        } catch let error {
            print("ERROR: \(error)")
        }
        
        let service = NetworkingService.shared
        service.getDataWith { (result) in
            switch result {
            case .Success(let data):
                self.clearData()
                self.saveInCoreData(array: data)
                
            case .Error(let message):
                DispatchQueue.main.async {
                    self.showError(vc)
                    print(message)
                }
            }
        }
    }
    
    func showError(_ vc: UIViewController) {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        vc.present(ac, animated: true)
    }
    
    func clearData() {
        do {
            let context = PersistenceService.shared.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Stocks")
            do {
                let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                _ = objects.map{$0.map{context.delete($0)}}
                PersistenceService.shared.saveContext()
            } catch let error {
                print("ERROR DELETING : \(error)")
            }
        }
    }
    
    func saveInCoreData(array: [[String: AnyObject]]) {
        _ = array.map{self.createStockEntityFrom(dictionary: $0)}
        do {
            try PersistenceService.shared.persistentContainer.viewContext.save()
        } catch let error {
            print(error)
        }
    }
    
    func createStockEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
        let context = PersistenceService.shared.persistentContainer.viewContext
        
        if let entity = NSEntityDescription.insertNewObject(forEntityName: "Stocks", into: context) as? Stocks {
            entity.symbol = dictionary["symbol"] as? String
            entity.longName = dictionary["longName"] as? String
            entity.regularMarketPrice = dictionary["regularMarketPrice"] as! Double
            entity.regularMarketDayLow = dictionary["regularMarketDayLow"] as! Double
            entity.regularMarketDayHigh = dictionary["regularMarketDayHigh"] as! Double
            entity.fiftyTwoWeekLow = dictionary["fiftyTwoWeekLow"] as! Double
            entity.fiftyTwoWeekHigh = dictionary["fiftyTwoWeekHigh"] as! Double
            return entity
        }
        return nil
    }
}
