//
//  FavouriteViewModel.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 22.10.2023.
//

import Foundation

final class FavouriteViewModel: ObservableObject {
    
    static let shared = FavouriteViewModel()
    
    @Published var sortedCoins = [FavouriteCoin]().sorted {
        $0.name < $1.name
    }
    
    func onAppear() {
        load()
        updateUI()
    }
    // Remove coin by swipe from CoreData and list
    func swipeToRemove(at offsets: IndexSet) {
        removeFromFavourites(withIndex: offsets)
        sortedCoins.remove(atOffsets: offsets)
        }
    
    // MARK: - Private
    
    private var favCoins = [FavouriteCoin]()
    private func load() {
        favCoins = FavouritesManager.shared.load()
    }
    
    private func updateUI() {
        sortedCoins = favCoins.sorted {
            $0.name < $1.name
        }
    }
    // Remove coin from CoreData - Favourites
    private func removeFromCoreData(id: String) {
        FavouritesManager.shared.removeCoin(withId: id)
     }
    // Remove Coin by Swipe from Favourites
    private func removeFromFavourites(withIndex index: IndexSet) {
        for index in index {
            let coin = sortedCoins[index]
            removeFromCoreData(id: String(coin.id))
        }
    }
}
