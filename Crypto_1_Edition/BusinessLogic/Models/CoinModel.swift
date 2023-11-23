//
//  CoinModel.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 18.08.2023.
//

import Foundation

struct Response: Codable {
    var data: [CoinModel]
}

struct CoinModel: Codable, Identifiable {
    let id: Int
    let name, symbol: String
    let cmcRank: Int
    let quote: Quote
}

    struct Quote: Codable {
        let usd: Usd
        enum CodingKeys: String, CodingKey {
            case usd = "USD"
        }
    }

struct Usd: Codable {
    let price: Double
    let volumeChange24H: Double
    let percentChange24H: Double
}
// Images
struct CoinImage: Codable {
    let logo: String
    let description: String
    let urls: Urls
    var imageUrl: URL? {
        return URL(string: logo)
    }
}

struct ResponseImage: Codable {
    var data: [String: CoinImage]
}

struct Urls: Codable {
    let website: [String]
}
// Coin Example
extension CoinModel {
    static var sample = CoinModel(
        id: 1,
        name: "Bitcoin",
        symbol: "BTC",
        cmcRank: 2,
        quote: Quote(usd: Usd(price: 26092.5448, volumeChange24H: -23.7318, percentChange24H: -1.43441697)))
}
// Coin Example
extension CoinImage {
    static var sample = CoinImage(logo: "https://s2.coinmarketcap.com/static/img/coins/64x64/1.png", description: "ETH is a COIN!", urls: Urls(website: ["https://s2.coinmarketcap.com"]))
}
