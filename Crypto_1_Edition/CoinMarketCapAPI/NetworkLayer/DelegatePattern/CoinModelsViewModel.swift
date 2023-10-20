//
//  CoinModelsViewModel.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 03.10.2023.
//
protocol CoinsDelegate {
    func receive(_ result: [CoinModel])
}

import Foundation

class CoinModelsViewModel: ObservableObject {
    @Published var coinModels: [CoinModel] = []
    // Showing list of CoinModels
    func showAll() {
        CoinModelProvider.shared.subscribe(self)
    }
    // Hide list of CoinModels
    func hideAll() {
        coinModels.removeAll()
    }
}

extension CoinModelsViewModel: CoinsDelegate {
    func receive(_ result: [CoinModel]) {
        coinModels = result
        CoinModelProvider.shared.unsubscribe(self)
    }
}
