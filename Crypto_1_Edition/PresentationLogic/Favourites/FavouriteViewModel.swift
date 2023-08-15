//
//  FavouriteViewModel.swift
//  Crypto_1_Edition
//
//  Created by Siarhei Kuryan on 04.07.2023.
//

import Foundation

final class FavouriteViewModel: ObservableObject {
    
    @Published var items = [Coin]().sorted {
        $0.name < $1.name
    }
    // Remove coin by swipe from CoreData and list
    func swipeRemove(at offsets: IndexSet) {
        removeCoin(withIndex: offsets)
        items.remove(atOffsets: offsets)
        }
    // Update list
    func onAppear() {
        load()
        updateUI()
    }
   
    // MARK: - Private
    private var cdm = CoreDataManager()
    private var cdmItems = Array(Set([Coin]()))
    private func load() {
        cdmItems = Array(Set(cdm.load().map({ Coin(databaseObject: $0)}))).sorted {
            $0.name < $1.name
        }
    }
    //Update UI
    private func updateUI() {
        items = Array(cdmItems).sorted {
            $0.name < $1.name
        }
    }
    // Remove coin from CoreData - Favourites
    private func removePortfolioId(id: String) {
         cdm.removeCoin(withId: id)
     }
    //to remove Coin by Swipe from Favourites
    private func removeCoin(withIndex indeX: IndexSet) {
        for index in indeX {
            let coin = items[index]
            removePortfolioId(id: coin.id)
        }
    }
}
