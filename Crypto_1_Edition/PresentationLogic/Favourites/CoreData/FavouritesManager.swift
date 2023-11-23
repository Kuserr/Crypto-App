//
//  FavouritesManager.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 22.10.2023.
//

import CoreData
import Foundation

final class FavouritesManager {
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavouritesContainer")
        container.loadPersistentStores { description, error in
            if let error = error { fatalError("Favourites Container failed: \(error.localizedDescription)")
            }
        }
        return container
    }()
    let context = FavouritesManager.persistentContainer.viewContext

    // Save coin to CoreData
    func save(coinModel: CoinModel) {
        let favCoin = FavouriteCoin(context: context)
        favCoin.id = String(coinModel.id)
        favCoin.symbol = coinModel.symbol
        favCoin.name = coinModel.name
        do {
            try context.save()
        } catch {
            print("Failed to save Favourite coin \(error)")
        }
    }
    // Remove coin from CoreData
    func removeCoin(withId id: String) {
        let predicate = NSPredicate(format: "id == %@", id)
        let request = FavouriteCoin.getAllFavCoinsRequest()
        request.predicate = predicate
        do {
            let favCoin = try context.fetch(request)
            if let coin = favCoin.first {
                context.delete(coin)
            }
            try context.save()
        } catch {
            print("Error - coin not found in favourite or already deleted")
        }
    }
    // Load all existed coins from CoreData
    func load() -> [FavouriteCoin] {
        let request = FavouriteCoin.getAllFavCoinsRequest()
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
}
