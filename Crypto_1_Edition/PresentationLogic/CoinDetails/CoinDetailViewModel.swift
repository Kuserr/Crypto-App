//
//  CoinDetailViewModel.swift
//  Crypto_1_Edition
//
//  Created by Anton Marunko on 29.06.2023.
//

import Foundation

final class CoinDetailViewModel: ObservableObject {
    var name: String
    var url: URL
    var descriptions: String
    var shortName: String
    var foundersDescription: String
    var id: String
    var savedItems = Set([Coinss]())
    var aboutSectionTitle: String {
        return "What Is \(name) (\(shortName))?"
    }
    
    var foundersSectionTitle: String {
        return "Who are the Founders of \(name)?"
    }

    var navigationBarTitle: String {
        return "About \(name)"
    }

    //var db = Database()
    var cdm = CoreDataManager()
    
    /*
    //removes the Coin Id if load already contains that Id
    func removeId() {
        if savedItems.contains(id) {
          savedItems.remove(id)
        }
        cdm.save(items: savedItems)
    }
    
    // adds the Coin Id to saveditems and saves to UserDefaults
    func addId() {
        if !savedItems.contains(id)  {
            savedItems.insert(id)
        }
        db.save(items: savedItems)
    }
*/
    
    func removeId() {
        if savedItems.contains(Coinss()) {
            savedItems.remove(Coinss())
        }
        cdm.save(id: id, name: name, shortName: shortName, url: url, descriptions: descriptions, foundersDescription: foundersDescription)
    }
                
    func addId() {
        if !savedItems.contains(Coinss())  {
            savedItems.insert(Coinss())
        }
            cdm.save(id: id, name: name, shortName: shortName, url: url, descriptions: descriptions, foundersDescription: foundersDescription)
                }
                
     
    init(coin: Coin) {
        self.id = coin.id
        self.name = coin.name
        self.url = coin.url
        self.descriptions = coin.descriptions
        self.shortName = coin.shortName
        self.foundersDescription = coin.foundersDescription
        savedItems = Set(cdm.load())
        
    }
}
