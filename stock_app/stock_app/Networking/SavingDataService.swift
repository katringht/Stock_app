//
//  SavingDataService.swift
//  stock_app
//
//  Created by Ekaterina Tarasova on 09.08.2021.
//

import Foundation
import CoreData

var fetchedhResultController: NSFetchedResultsController<NSFetchRequestResult> = {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Stocks.self))
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
    let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: PersistenceService.shared.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
    frc.delegate = (frc as! NSFetchedResultsControllerDelegate)
    return frc
    }()
