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
    private var portItems = Set([Coin]())
    
    //load Coins
    private func load() {
        portItems = Set(cdp.load().map({ Coin(databaseObject: $0)}))
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
    //Cancel an alert
    func cancel() {
        print("Operation was cancelled!")
    }
    
    func removePortfolioId() {
         cdp.removeCoin(withId: shortName)
     }
}
