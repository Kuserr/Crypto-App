//
//  CoinModel.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 18.08.2023.
//

import Foundation


//Main info
struct CoinModel: Codable, Identifiable, Hashable {
    let id, rank: Int
    let name, symbol: String
}

struct Response: Codable {
    var data: [CoinModel]
}


//Images
struct CoinImage: Codable {
    let logo: String
    
    var imageUrl: URL? {
        return URL(string: logo)
    }
}

struct ResponseImage: Codable {
    var data: [String: CoinImage]
}

//Coin Example
extension CoinModel {
    static var sample = CoinModel(
        id: 1,
        rank: 2,
        name: "Bitcoin",
        symbol: "BTC")
}

extension CoinImage {
    static var sample = CoinImage(logo: "https://s2.coinmarketcap.com/static/img/coins/64x64/1.png")
}
