//
//  FavouriteViewModel.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 22.10.2023.
//

import Foundation

final class FavouriteViewModel: ObservableObject {
    
    let dataService: FavouritesManager
    
    @Published var sortedCoins = [FavouriteCoin]().sorted {
        $0.name < $1.name
    }
    
    init(dataService: FavouritesManager) {
        self.dataService = dataService
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
        favCoins = dataService.load()
    }
    
    private func updateUI() {
        sortedCoins = favCoins.sorted {
            $0.name < $1.name
        }
    }
    // Remove coin from CoreData - Favourites
    private func removeFromCoreData(id: String) {
        dataService.removeCoin(withId: id)
     }
    // Remove Coin by Swipe from Favourites
    private func removeFromFavourites(withIndex index: IndexSet) {
        for index in index {
            let coin = sortedCoins[index]
            removeFromCoreData(id: String(coin.id))
        }
    }
}
