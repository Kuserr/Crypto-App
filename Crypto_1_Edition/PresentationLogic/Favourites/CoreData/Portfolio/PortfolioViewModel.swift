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
    var gavenName: Coin?
    let allDefaultCoins: [Coin] = Coin.coins
    var cdp = CoreDataPortfolio()
    // Update View
    func onAppear() {
        load()
        updateUI()
    }
    // Return Coin's name by id
    func fetchNameById(withId id: String) -> String {
          if let coinWithId = allDefaultCoins.first(where: {$0.id == id}) {
            myCoinName = coinWithId.name
          }
          return myCoinName
      }

    // Return Coin by id
    func giveMeCoin(withId id: String) -> Coin? {
        if let coinWithId = allDefaultCoins.first(where: {$0.id == id}) {
            gavenName = coinWithId
        }
        return gavenName
    }
    // Remove coin by swipe from CoreData
    func removeRows(at offsets: IndexSet) {
        removeCoin(withIndex: offsets)
        portfolioItems.remove(atOffsets: offsets)
        }
    // MARK: - Private
    private var portItems = Array(Set([PortfolioCoinModel]())).sorted {$0.quantity > $1.quantity}
    // Load Coins
    private func load() {
        portItems = Array(Set(cdp.load().map({ PortfolioCoinModel(databaseObject: $0)}))).sorted {$0.quantity > $1.quantity}
    }
    // Update UI
    private func updateUI() {
        portfolioItems = Array(portItems).sorted {$0.quantity > $1.quantity}
    }

    // Remove coin from CoreData
    private func removePortfolioId(id: String) {
         cdp.removeCoin(withId: id)
     }
    // Remove Coin by Swipe from Portfolio
    private func removeCoin(withIndex indeX: IndexSet) {
        for index in indeX {
            let coin = portfolioItems[index]
            removePortfolioId(id: coin.shortId)
        }
    }
}
