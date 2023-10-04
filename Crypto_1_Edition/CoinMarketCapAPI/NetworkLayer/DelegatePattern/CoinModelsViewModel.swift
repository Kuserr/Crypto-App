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
    
    init() {
        CoinModelProvider.shared.subscribe(self)
    }
}

extension CoinModelsViewModel: CoinsDelegate {
    func receive(_ result: [CoinModel]) {
        coinModels = result
    }
}
