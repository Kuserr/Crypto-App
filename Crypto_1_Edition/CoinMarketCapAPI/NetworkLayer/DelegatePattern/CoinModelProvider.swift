//
//  CoinModelProvider.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 03.10.2023.
//

import Foundation
import Moya

class CoinModelProvider {
    
    static let shared = CoinModelProvider()
    // Add a new delegate to receive [CoinModel]
    func subscribe(_ delegate: CoinsDelegate) {
        delegates.append(delegate)
        fetchMoyaCoins()
    }
    // MARK: - Private
    private var delegates: [CoinsDelegate] = []
    private let provider = MoyaProvider<NetworkTarget>(plugins: [NetworkLoggerPlugin()])
    // Fetch data from API
    private func fetchMoyaCoins() {
        provider.request(.getCoinModels) { result in
            switch result {
            case let .success(response):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let results = try decoder.decode(Response.self, from: response.data)
                    self.send(coinModels: results.data)
                } catch let error {
                    print("Error in \(error)")
                }
            case let .failure(error):
                print("Error in \(error)")
            }
        }
    }
    // Distribute [CoinModel] to all registered delegates
    private func send(coinModels: [CoinModel]) {
        delegates.forEach { delegate in
            delegate.receive(coinModels)
        }
    }
}
