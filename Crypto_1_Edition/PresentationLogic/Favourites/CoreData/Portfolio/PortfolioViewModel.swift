//
//  PortfolioViewModel.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 24.07.2023.
//

import Foundation

final class PortfolioViewModel: ObservableObject {
    @Published var portfolioItems = [PortfolioCoinModel]()
    var myCoinName: String = ""
    var myCoinIndex: Int = 0
    let allDefaultCoins: [Coin] = Coin.coins
    
    //Update View
    func onAppear() {
        load()
        updateUI()
    }
    func a() {
        
    }
    func removeCoin(withIndex index: Int) {
        let coin = portfolioItems[index]
        removePortfolioId(id: coin.shortId)
        onAppear()
    }
/*
    func coinIndex(withId id: String) -> Int {
        if let takeIndex = portfolioItems.firstIndex(where: {$0.id == id}) {
            myCoinIndex = takeIndex
        }
        return myCoinIndex
    }
  */
    func fetchNameById(withId id: String) -> String {
        if let coinWithId = allDefaultCoins.first(where: {$0.id == id}) {
          myCoinName = coinWithId.name
        }
        return myCoinName
    }
    
    
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
    
    private func removePortfolioId(id: String) {
         cdp.removeCoin(withId: id)
     }
}
