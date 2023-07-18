//
//  CoreDataManager.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 17.07.2023.
//

import CoreData
import Foundation

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "CoinsContainer")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }
    
    func save(id: String, name: String, shortName: String, url: URL, descriptions: String, foundersDescription: String) {
        let coinss = Coinss(context: persistentContainer.viewContext)
        coinss.id = id
        coinss.name = name
        coinss.shortName = shortName
        coinss.url = url
        coinss.descriptions = descriptions
        coinss.foundersDescription = foundersDescription
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save movie \(error)")
        }
    }
    
    func load() -> [Coinss] {
        let fetchRequest: NSFetchRequest<Coinss> = Coinss.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    
}
