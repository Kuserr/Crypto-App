//
//  CoreDataPortfolio.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 24.07.2023.
//


import CoreData
import Foundation

class CoreDataPortfolio {
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PortfolioContainer")
        container.loadPersistentStores { description, error in
            if let error = error { fatalError("Core Data Store failed: \(error.localizedDescription)")
            }
        }
        return container
    }()
    let context = CoreDataPortfolio.persistentContainer.viewContext

    // Save coins to CoreData
    func save(coinn: PortfolioCoinModel) {
        let coinss = PortfolioCoin(context: context)
        coinss.quantity = coinn.quantity
        coinss.id = coinn.id
        do {
            try context.save()
        } catch {
            print("Failed to save coin \(error)")
        }
    }
    
    //Update coins quantity in CoreData
    func coinUpdate(withId id: String, withQuantity: Double) {
        let predicate = NSPredicate(format: "id == %@", id)
        let request = PortfolioCoin.getAllPortfolioCoinRequest()
        request.predicate = predicate
        do {
            let coinn = try context.fetch(request)
            if let coinn = coinn.first {
                coinn.quantity = coinn.quantity + withQuantity
            }
            try context.save()
        } catch {
            print("Error - coin not found or already deleted")
        }
    }
    
    //Remove coin from CoreData
    func removeCoin(withId id: String) {
        let predicate = NSPredicate(format: "id == %@", id)
        let request = PortfolioCoin.getAllPortfolioCoinRequest()
        request.predicate = predicate
        do {
            let coinn = try context.fetch(request)
            if let coinn = coinn.first {
                context.delete(coinn)
            }
            try context.save()
        } catch {
            print("Error - coin not found or already deleted")
        }
    }
    
    // load all existed coins from CoreData
    func load() -> [PortfolioCoin] {
        let request = PortfolioCoin.getAllPortfolioCoinRequest()
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
}
