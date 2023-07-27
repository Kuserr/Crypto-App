//
//  CoinDetailViewModel.swift
//  Crypto_1_Edition
//
//  Created by Siarhei Kuryan on 29.06.2023.
//

import Foundation

final class CoinDetailViewModel: ObservableObject {
    var name: String
    var url: URL
    var descriptions: String
    var shortName: String
    var foundersDescription: String
    var id: String
    var savedItems = Set([String]())
    // Portfolio
    var savedPortfolioItems = Set([String]())
    
    var aboutSectionTitle: String {
        return "What Is \(name) (\(shortName))?"
    }
    
    var foundersSectionTitle: String {
        return "Who are the Founders of \(name)?"
    }

    var navigationBarTitle: String {
        return "About \(name)"
    }
    
// Functions for favourites
    var cdm = CoreDataManager()
    
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
    var cdp = CoreDataPortfolio()
    
    
   func addPortfolioId() {
        if !savedPortfolioItems.contains(id)  {
            savedPortfolioItems.insert(id)
        }
        cdp.save(coinn: Coin(name: self.name,
                            shortName: self.shortName,
                            url: self.url,
                            descriptions: self.descriptions,
                            foundersDescription: self.foundersDescription))
    }
    
   func removePortfolioId() {
       cdp.removeCoin(withId: self.id)
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

