//
//  CoinModel.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 18.08.2023.
//

import Foundation

struct CoinModel: Codable, Identifiable, Hashable {
    let id, rank: Int
    let name, symbol: String
}

struct Response: Codable {
    var data: [CoinModel]
}

//Coin Example
extension CoinModel {
    static var sample = CoinModel(
        id: 1,
        rank: 2,
        name: "Bitcoin",
        symbol: "BTC")
}
