//
//  PortfolioViewModel.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 24.07.2023.
//

import Foundation

final class PortfolioViewModel: ObservableObject {
    @Published var portfolioItems = [PortfolioCoinModel]().sorted {$0.quantity > $1.quantity}
    var myCoinName: String = ""
    var myCoinIndex: Int?
    let allDefaultCoins: [Coin] = Coin.coins
    
    
    //Update View
    func onAppear() {
        load()
        updateUI()
    }
    
      func fetchNameById(withId id: String) -> String {
          if let coinWithId = allDefaultCoins.first(where: {$0.id == id}) {
            myCoinName = coinWithId.name
          }
          return myCoinName
      }
    
    func removeCoin(withIndex index: Int) {
        let coin = portfolioItems[index]
        removePortfolioId(id: coin.shortId)
    }

    func coinIndex(withId id: String) -> Int? {
        if let takeIndex = portfolioItems.firstIndex(where: {$0.id == id }) {
            myCoinIndex = takeIndex
        }
        return myCoinIndex
    }
  
    
    // MARK: - Private
    var cdp = CoreDataPortfolio()
    private var portItems = Array(Set([PortfolioCoinModel]())).sorted {$0.quantity > $1.quantity}
    
    //load Coins
    private func load() {
        portItems = Array(Set(cdp.load().map({ PortfolioCoinModel(databaseObject: $0)}))).sorted {$0.quantity > $1.quantity}
    }
    //Update UI
    private func updateUI() {
        portfolioItems = Array(portItems).sorted {$0.quantity > $1.quantity}
    }
    
    private func removePortfolioId(id: String) {
         cdp.removeCoin(withId: id)
     }
}
