//
//  CoreDataManager.swift
//  Crypto_1_Edition
//
//  Created by Siarhei Kuryan on 10.07.2023.
//

import CoreData
import Foundation

class CoreDataManager {
    private static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoinsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data Store failed: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    // Get a reference to a managed object context
    let context = CoreDataManager.persistentContainer.viewContext
    
    func save(coin: Coin) {
        let coinss = Coinss(context: context)
        coinss.name = coin.name
        coinss.shortName = coin.shortName
        coinss.url = coin.url
        coinss.descriptions = coin.descriptions
        coinss.foundersDescription = coin.foundersDescription
        coinss.id = coin.id

        do {
            try context.save()
        } catch {
            print("Failed to save coin \(error)")
        }
    }

    func removeCoin(withId id: String) {
        let predicate = NSPredicate(format: "id == %@", id)
        let request = Coinss.getAllCoinsRequest()
        request.predicate = predicate
        do {
            let coin = try context.fetch(request)
            if let coin = coin.first {
                context.delete(coin)
            }
            try context.save()
        } catch {
            print("Error - coin not found or already deleted")
        }
    }
    
    func load() -> [Coinss] {
        let request = Coinss.getAllCoinsRequest()
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
}
