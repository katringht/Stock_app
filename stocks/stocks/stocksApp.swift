//
//  stocksApp.swift
//  stocks
//
//  Created by Ekaterina Tarasova on 18.03.2021.
//

import SwiftUI
import CoreData

@main
struct stocksApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentContainer.viewContext)
        }
    }
}

var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "DataStock")
    container.loadPersistentStores(completionHandler:{ (storeDescriptio, error) in
        if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    })
    return container
}()

func saveContext() {
    let context = persistentContainer.viewContext
    if context.hasChanges{
        do {
            try context.save()
            print("Data SAVE")
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
