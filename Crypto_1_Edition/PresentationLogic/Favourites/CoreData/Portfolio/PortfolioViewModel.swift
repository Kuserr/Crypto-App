//
//  PortfolioViewModel.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 24.07.2023.
//

import Foundation

final class PortfolioViewModel: ObservableObject {
    // tests, trying to save quantity
    //let manager = CoreDataPortfolio.instance
    //var savedPortfolioItems = Set([String]())
//    var name: String
//    var url: URL
//    var descriptions: String
//    var shortName: String
//    var foundersDescription: String
//    var id: String

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
    //Cancel an alert
    func cancel() {
        print("Operation was cancelled!")
    }

    func removeCoin(withIndex index: Int) {
        let coin = portfolioItems[index]
        removePortfolioId(id: coin.shortId)
        onAppear()
    }

    private func removePortfolioId(id: String) {
         cdp.removeCoin(withId: id)
     }
    
    /*
    // add id after toggle the button add
    func addPortfolioId() {
         if !savedPortfolioItems.contains(id)  {
             savedPortfolioItems.insert(id)
         }
         cdp.save(coin: Coin(name: self.name,
                             shortName: self.shortName,
                             url: self.url,
                             descriptions: self.descriptions,
                             foundersDescription: self.foundersDescription))
     }
    
    
    func removePortfolioId() {
        if savedPortfolioItems.contains(id) {
            savedPortfolioItems.remove(id)
        }
        cdp.removeCoin(withId: id)
    }
*/
    
    
    
    
    
    
    
    
    
    //add coins quantity
    /*
    func saveAs() {
        manager.saveQuantity()
        getMyCoins()
    }
    
    func getMyCoins() {
        let request = NSFetchRequest<MyCoins>(entityName: "MyCoins")
        do {
            mycoins = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
    }
    
    init() {
        getMyCoins()
    }
    var coinsQuan = ""
    func setQuan() -> String {
        coinsQuan
    }
    func addQuantities() {
        let coinsQuantity = CoinsQuantity(context: manager.context)
        coinsQuantity.quantity = setQuan()
        saveAs()
    }
     */
}
