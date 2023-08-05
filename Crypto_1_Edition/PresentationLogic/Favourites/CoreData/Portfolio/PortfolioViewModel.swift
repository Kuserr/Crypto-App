//
//  PortfolioViewModel.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 24.07.2023.
//

import Foundation

final class PortfolioViewModel: ObservableObject {
    @Published var portfolioItems = [PortfolioCoinModel]()
    
    // MARK: - Private
    var cdp = CoreDataPortfolio()
    private var portItems = Set([PortfolioCoinModel]())
    
    //load Coins
    private func load() {
        portItems = Set(cdp.load().map({ PortfolioCoinModel(databaseObject: $0)}))
    }
    //Update UI
    private func updateUI() {
        portfolioItems = Array(portItems)
    }

    //Update View
    func onAppear() {
        load()
        updateUI()
    }
    
    func removeCoin(withIndex index: Int) {
        let coin = portfolioItems[index]
        removePortfolioId(id: coin.shortId)
        onAppear()
    }

    private func removePortfolioId(id: String) {
         cdp.removeCoin(withId: id)
     }
}
