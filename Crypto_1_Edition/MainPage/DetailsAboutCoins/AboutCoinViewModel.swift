//
//  AboutCoinViewModel.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 22.10.2023.
//

import Foundation

final class AboutCoinViewModel: ObservableObject {
    
    @Published var quantity = ""
    var myCoinQuantity: Double?
    var isInFav: Bool = false
    let dataService: PortfolioManager
    let dataServiceFav: FavouritesManager
    
    init(coin: CoinModel, dataService: PortfolioManager, dataServiceFav: FavouritesManager) {
        self.id = String(coin.id)
        self.name = coin.name
        self.symbol = coin.symbol
        self.quote = coin.quote
        self.cmcRank = coin.cmcRank
        self.dataService = dataService
        self.dataServiceFav = dataServiceFav
    }
    
    // Save Coin to CoreData - Favourites
    func addToFavourite() {
        if isCoinInFav() == true {
            return
        } else {
            dataServiceFav.save(coinModel: CoinModel(id: Int(id) ?? 0, name: name, symbol: symbol, cmcRank: cmcRank, quote: quote))
        }
    }
    
    // Save Coin to CoreData - Portfolio
    func addToPortfolio() {
        dataService.save(portfolioModel: CryptoPortfolioModel(quantity: Double(quantity) ?? 0, id: id, name: name, symbol: symbol))
    }
    
    func updateCoin() {
        let predicate = NSPredicate(format: "id == %@", self.id)
        let request = CryptoPortfolioCoin.getAllCryptoPortfolioCoinRequest()
        request.predicate = predicate
        do {
            let coinn = try? dataService.context.fetch(request)
            if let coinn = coinn?.first {
                coinn.quantity += (Double(self.quantity) ?? 0)
            } else {
                dataService.save(portfolioModel: CryptoPortfolioModel(quantity: Double(quantity) ?? 0, id: id, name: name, symbol: symbol))
            }
            try dataService.context.save()
        } catch {
            print("Error - Portfolio coin not found or already deleted")
        }
    }
    // Remove coin from CoreData - Portfolio
    func removeFromFavourite() {
        dataServiceFav.removeCoin(withId: String(id))
    }
    
    // Return coin quantity from CoreData
    func giveQuantity() -> Double {
            let predicate = NSPredicate(format: "id == %@", self.id)
        let request = CryptoPortfolioCoin.getAllCryptoPortfolioCoinRequest()
            request.predicate = predicate
            do {
                let coinn = try dataService.context.fetch(request)
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
            let coinn = try dataService.context.fetch(request)
            if let coinn = coinn.first {
                coinn.quantity -= (Double(quantity) ?? 0)
                if coinn.quantity >= 0 {
                    try dataService.context.save()
                } else {
                    coinn.quantity = 0
                }
            }
            try dataService.context.save()
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
            let coinn = try dataService.context.fetch(request)
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
    // Check if coin is already in Favourites
    private func isCoinInFav() -> Bool {
        let predicate = NSPredicate(format: "id == %@", self.id)
        let request = FavouriteCoin.getAllFavCoinsRequest()
        request.predicate = predicate
        do {
            let favCoin = try dataServiceFav.context.fetch(request)
            if let coin = favCoin.first {
                if coin.name == name {
                    isInFav = true
                    return true
                } else {
                    isInFav = false
                    return isInFav
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return isInFav
    }
}
