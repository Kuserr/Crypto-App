//
//  AboutCoinViewModel.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 22.10.2023.
//

import Foundation

final class AboutCoinViewModel: ObservableObject {
    
    @Published var quantity = ""
    var favCoins = Set([String]())
    var myCoinQuantity: Double?
    
    init(coin: CoinModel) {
        self.id = String(coin.id)
        self.name = coin.name
        self.symbol = coin.symbol
        self.quote = coin.quote
        self.cmcRank = coin.cmcRank
    }
    // Save Coin to CoreData - Favourites
    func addToFavourite() {
        if favouritesLoad.contains(where: {$0.name == name}) {
        } else {
            return
        }
        FavouritesManager.shared.save(coinModel: CoinModel(id: Int(id) ?? 0, name: name, symbol: symbol, cmcRank: cmcRank, quote: quote))
    }
    
    // Save Coin to CoreData - Portfolio
    func addToPortfolio() {
        PortfolioManager.shared.save(portfolioModel: CryptoPortfolioModel(quantity: Double(quantity) ?? 0, id: id, name: name, symbol: symbol))
    }
    
    func updateCoin() {
        let predicate = NSPredicate(format: "id == %@", self.id)
        let request = CryptoPortfolioCoin.getAllCryptoPortfolioCoinRequest()
        request.predicate = predicate
        do {
            let coinn = try? PortfolioManager.shared.context.fetch(request)
            if let coinn = coinn?.first {
                coinn.quantity += (Double(self.quantity) ?? 0)
            } else {
                PortfolioManager.shared.save(portfolioModel: CryptoPortfolioModel(quantity: Double(quantity) ?? 0, id: id, name: name, symbol: symbol))
            }
            try PortfolioManager.shared.context.save()
        } catch {
            print("Error - Portfolio coin not found or already deleted")
        }
    }
    // Remove coin from CoreData - Portfolio
    func removeFromFavourite() {
        FavouritesManager.shared.removeCoin(withId: String(id))
    }
    
    // Return coin quantity from CoreData
    func giveQuantity() -> Double {
            let predicate = NSPredicate(format: "id == %@", self.id)
        let request = CryptoPortfolioCoin.getAllCryptoPortfolioCoinRequest()
            request.predicate = predicate
            do {
                let coinn = try PortfolioManager.shared.context.fetch(request)
                if let coinn = coinn.first {
                    myCoinQuantity = coinn.quantity
                }
            } catch {
                print("Error - coin not found!")
            }
            return myCoinQuantity ?? 0
        }
    
    // Delete coins quantity from CoreData - Portfolio
    func coinQuantityDel() {
        let predicate = NSPredicate(format: "id == %@", self.id)
        let request = CryptoPortfolioCoin.getAllCryptoPortfolioCoinRequest()
        request.predicate = predicate
        do {
            let coinn = try PortfolioManager.shared.context.fetch(request)
            if let coinn = coinn.first {
                coinn.quantity -= (Double(quantity) ?? 0)
                if coinn.quantity >= 0 {
                    try PortfolioManager.shared.context.save()
                } else {
                    coinn.quantity = 0
                }
            }
            try PortfolioManager.shared.context.save()
        } catch {
            print("Error - coin not found or already deleted")
        }
    }
    // Check the quantity of coins in CoreData
    func checkCoinQuantity() -> Double {
        let predicate = NSPredicate(format: "id == %@", self.id)
        let request = CryptoPortfolioCoin.getAllCryptoPortfolioCoinRequest()
        request.predicate = predicate
        do {
            let coinn = try PortfolioManager.shared.context.fetch(request)
            if let coinn = coinn.first {
                if coinn.quantity >= 0 {
                    myCoinQuantity = coinn.quantity
                    return myCoinQuantity!
                } else {
                    myCoinQuantity = 0
                    return myCoinQuantity!
                }
            }
        } catch {
            print("Error - coin not found or already deleted")
        }
        return myCoinQuantity ?? 0
    }
    
    // MARK: - Private
    
    private var id: String
    private var name: String
    private var symbol: String
    private var quote: Quote
    private var cmcRank: Int
    private let favouritesLoad = FavouritesManager.shared.load()
}
