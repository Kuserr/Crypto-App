//
//  FactoryPattern.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 06.10.2023.
//
//

import Foundation

protocol Coins {
    var id: Int {get}
    var name: String {get}
    var cmcRank: Int {get}
    var topRating: String {get}
}

public class CoinsModel: Coins {
    
    let id: Int
    let name: String
    let cmcRank: Int
    let topRating: String
    
    init(id: Int, name: String, cmcRank: Int, topRating: String) {
        self.id = id
        self.name = name
        self.cmcRank = cmcRank
        self.topRating = topRating
    }
}

public class TopCoinsFactory {
    
    static let shared = TopCoinsFactory()
    private init() {}
    func sortCoins(for model: CoinModel) -> CoinsModel {
        let name = model.name
        let id = model.id
        let cmcRank = model.cmcRank
        let topRating: String
        switch cmcRank {
        case 0...30: topRating = "Top30"
        case 31...100: topRating = "Top100"
        default:
            topRating = "No data here!"
        }
        return CoinsModel(id: id, name: name, cmcRank: cmcRank, topRating: topRating)
    }
}

final class FactoryViewModel: ObservableObject {
    
    private let networkManager = NetworkManager()
    var coinsData: [CoinModel] = []
    @Published var itemCoins: [Coins] = []
    
            init() {
                loadMoyaCoins()
            }
    
        private func loadData() {
            for coin in coinsData {
                itemCoins.append(TopCoinsFactory.shared.sortCoins(for: coin))
            }
        }
    
        private func loadMoyaCoins() {
            networkManager.fetchAllMoyaCoins { [weak self] result in
                switch result {
                case .success(let data):
                    let result = data.data
                    self?.coinsData = result
                    self?.loadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
}
