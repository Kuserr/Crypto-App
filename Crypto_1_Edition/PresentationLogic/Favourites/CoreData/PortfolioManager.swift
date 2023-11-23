//
//  PortfolioManager.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 23.10.2023.
//

import CoreData
import Foundation

final class PortfolioManager {
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CryptoPortfolioContainer")
        container.loadPersistentStores { description, error in
            if let error = error { fatalError("CryptoPortfolioContainer failed: \(error.localizedDescription)")
            }
        }
        return container
    }()
    let context = PortfolioManager.persistentContainer.viewContext

    // Save coin to CoreData
    func save(portfolioModel: CryptoPortfolioModel) {
        let portfolioCoin = CryptoPortfolioCoin(context: context)
        portfolioCoin.id = portfolioModel.id
        portfolioCoin.quantity = portfolioModel.quantity
        portfolioCoin.name = portfolioModel.name
        portfolioCoin.symbol = portfolioModel.symbol
        do {
            try context.save()
        } catch {
            print("Failed to save Portfolio coin \(error)")
        }
    }
    // Remove coin from CoreData
    func removeCoin(withId id: String) {
        let predicate = NSPredicate(format: "id == %@", id)
        let request = CryptoPortfolioCoin.getAllCryptoPortfolioCoinRequest()
        request.predicate = predicate
        do {
            let portfolioCoin = try context.fetch(request)
            if let coin = portfolioCoin.first {
                context.delete(coin)
            }
            try context.save()
        } catch {
            print("Error - coin not found in Portfolio or already deleted")
        }
    }
    // Load all existed coins from CoreData
    func load() -> [CryptoPortfolioCoin] {
        let request = CryptoPortfolioCoin.getAllCryptoPortfolioCoinRequest()
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
}
