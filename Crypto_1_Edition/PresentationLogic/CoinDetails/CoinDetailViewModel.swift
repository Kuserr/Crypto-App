//
//  CoinDetailViewModel.swift
//  Crypto_1_Edition
//
//  Created by Siarhei Kuryan on 29.06.2023.
//

import Foundation
import Combine

final class CoinDetailViewModel: ObservableObject {

    @Published var quantity = ""
    var name: String
    var url: URL
    var descriptions: String
    var shortName: String
    var foundersDescription: String
    var id: String
    var savedItems = Set([String]())
    // Portfolio
    var aboutSectionTitle: String {
        return "What Is \(name) (\(shortName))?"
    }
    
    var foundersSectionTitle: String {
        return "Who are the Founders of \(name)?"
    }

    var navigationBarTitle: String {
        return "About \(name)"
    }
    var maxToDelete: Double?
    var cdp = CoreDataPortfolio()
    var cdm = CoreDataManager()
    var myCoinQuantity: Double?
    private let context = CoreDataPortfolio.persistentContainer.viewContext
    
// Functions for favourites
    var portfolioManager = CoreDataPortfolio()


    func removeId() {
        cdm.removeCoin(withId: id)
    }
                
    func addId() {
        if !savedItems.contains(id)  {
            savedItems.insert(id)
        }
        cdm.save(coin: Coin(name: self.name,
                            shortName: self.shortName,
                            url: self.url,
                            descriptions: self.descriptions,
                            foundersDescription: self.foundersDescription))
    }
     
    // Functions for Portfolio
    func addPortfolioId() {
       portfolioManager.save(coinn: PortfolioCoinModel(quantity: Double(quantity) ?? 0, shortId: id))
    }
    
    //Update coins quantity in CoreData
    func updateCoin() {
        let predicate = NSPredicate(format: "id == %@", self.id)
        let request = PortfolioCoin.getAllPortfolioCoinRequest()
        request.predicate = predicate
        do {
           let coinn = try? context.fetch(request)
            if let coinn = coinn?.first {
                coinn.quantity = coinn.quantity + (Double(self.quantity) ?? 0)
            } else {
                cdp.save(coinn: PortfolioCoinModel(quantity: Double(quantity) ?? 0, shortId: self.id))
            }
            try context.save()
        } catch {
            print("Error - coin not found or already deleted")
        }
    }
    
    //Delete coins quantity in CoreData
    func coinQuantityDel() {
        let predicate = NSPredicate(format: "id == %@", self.id)
        let request = PortfolioCoin.getAllPortfolioCoinRequest()
        request.predicate = predicate
        do {
            let coinn = try context.fetch(request)
            if let coinn = coinn.first {
                coinn.quantity = coinn.quantity - (Double(self.quantity) ?? 0)
                if coinn.quantity >= 0 {
                    try context.save()
                } else {
                    coinn.quantity = 0
                }
            }
            try context.save()
        } catch {
            print("Error - coin not found or already deleted")
        }
    }
    
   func removePortfolioId() {
       cdp.removeCoin(withId: self.id)
    }
   
    //Check the quantity of coin in CoreData
    func checkQuantity() -> Double {
        let predicate = NSPredicate(format: "id == %@", self.id)
        let request = PortfolioCoin.getAllPortfolioCoinRequest()
        request.predicate = predicate
        do {
            let coinn = try context.fetch(request)
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
    
    
    init(coin: Coin) {
        self.id = coin.id
        self.name = coin.name
        self.url = coin.url
        self.descriptions = coin.descriptions
        self.shortName = coin.shortName
        self.foundersDescription = coin.foundersDescription
    }
    
}

