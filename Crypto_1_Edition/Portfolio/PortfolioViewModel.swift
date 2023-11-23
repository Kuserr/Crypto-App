//
//  PortfolioViewModel.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 23.10.2023.
//

import Foundation

final class PortfolioViewModel: ObservableObject {
    
    @Published var portfolioCoins = [CryptoPortfolioCoin]().sorted {
        $0.quantity > $1.quantity }
    let dataService: PortfolioManager
    
    init(dataService: PortfolioManager) {
        self.dataService = dataService
    }
    
    func onAppear() {
        load()
        updateUI()
    }
    // Remove coin by swipe from CoreData
    func swipeToRemove(at offsets: IndexSet) {
        removeCoin(withIndex: offsets)
        portfolioCoins.remove(atOffsets: offsets)
        }
    
    // MARK: - Private
    
    private var loadedCoins = [CryptoPortfolioCoin]()
    // Load coins from CoreData - Portfolio
    private func load() {
        loadedCoins = dataService.load()
    }
    // Update UI
    private func updateUI() {
        portfolioCoins = loadedCoins.sorted {
            $0.quantity > $1.quantity }
        print("Now - there are \(portfolioCoins) ")
    }
    // Remove Coin from CoreData
    private func removeFromPortfolio(id: String) {
        dataService.removeCoin(withId: id)
     }
    // Remove Coin by Swipe portfolioCoins
    private func removeCoin(withIndex indeX: IndexSet) {
        for index in indeX {
            let coin = portfolioCoins[index]
            removeFromPortfolio(id: coin.id)
        }
    }
}
