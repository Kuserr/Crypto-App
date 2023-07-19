//
//  CoreDataManager.swift
//  Crypto_1_Edition
//
//  Created by Siarhei Kuryan on 10.07.2023.
//

import CoreData
import Foundation

class CoreDataManager {
    
    /*
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "CoinsContainer")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
     */
    
    private static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoinsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data Store failed: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return Self.persistentContainer.viewContext
    }
    
    func save(coin: Coin) {
        let coinss = Coinss(context: CoreDataManager.persistentContainer.viewContext)
        coinss.name = coin.name
        coinss.shortName = coin.shortName
        coinss.url = coin.url
        coinss.descriptions = coin.descriptions
        coinss.foundersDescription = coin.foundersDescription
        coinss.id = coin.id

        do {
            try CoreDataManager.persistentContainer.viewContext.save()
        } catch {
            print("Failed to save coin \(error)")
        }
    }

    func removeCoin(withId id: String) {
        let predicate = NSPredicate(format: "id == %@", id)
        let request = Coinss.getAllCoinsRequest()
        request.predicate = predicate

        do {
            let coin = try CoreDataManager.persistentContainer.viewContext.fetch(request)
            if let coin = coin.first {
                CoreDataManager.persistentContainer.viewContext.delete(coin)
            }
        } catch {
            print("Error - coin not found or already deleted")
        }
    }
    
    func load() -> [Coinss] {
        let request = Coinss.getAllCoinsRequest()
        do {
            return try CoreDataManager.persistentContainer.viewContext.fetch(request)
        } catch {
            return []
        }
    }
}
