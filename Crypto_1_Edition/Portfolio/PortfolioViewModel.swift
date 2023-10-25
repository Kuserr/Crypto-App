//
//  PortfolioViewModel.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 23.10.2023.
//

import Foundation

final class PortfolioViewModel: ObservableObject {
    
    @Published var portfCoins = [CryptoPortfolioCoin]().sorted {
        $0.quantity > $1.quantity }
    
    func onAppear() {
        load()
        updateUI()
    }
    // Remove coin by swipe from CoreData
    func swipeToRemove(at offsets: IndexSet) {
        removeCoin(withIndex: offsets)
        portfCoins.remove(atOffsets: offsets)
        }
    // MARK: - Private
    private var loadedCoins = [CryptoPortfolioCoin]()
    // Load coins from CoreData - Portfolio
    private func load() {
        loadedCoins = PortfolioManager.shared.load()
    }
    // Update UI
    private func updateUI() {
        portfCoins = loadedCoins.sorted {
            $0.quantity > $1.quantity }
        print("Now - there are \(portfCoins) ")
    }
    // Remove Coin from CoreData
    private func removeFromPortfolio(id: String) {
        PortfolioManager.shared.removeCoin(withId: id)
     }
    // Remove Coin by Swipe portfCoins
    private func removeCoin(withIndex indeX: IndexSet) {
        for index in indeX {
            let coin = portfCoins[index]
            removeFromPortfolio(id: coin.id)
        }
    }
}
