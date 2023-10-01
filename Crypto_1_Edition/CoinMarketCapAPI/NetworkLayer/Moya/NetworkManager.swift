//
//  NetworkManager.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 31.08.2023.
//

import Foundation
import Moya

protocol Networkable {
    func fetchAllMoyaCoins(completion: @escaping AllMoyaCoinsCallback)
    func fetchAllMoyaImages(withId: String, completion: @escaping ImagesMoyaCallback)
}

typealias ImagesMoyaCallback = (Result<ResponseImage, Error>) -> Void
typealias AllMoyaCoinsCallback = (Result<Response, Error>) -> Void

final class NetworkManager: Networkable, ObservableObject {
    private let provider = MoyaProvider<NetworkTarget>(plugins: [NetworkLoggerPlugin()])
    // Decoding CoinModels from JSON data
    func fetchAllMoyaCoins(completion: @escaping AllMoyaCoinsCallback) {
        provider.request(.getCoinModels) { result in
            switch result {
            case let .success(response):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let results = try decoder.decode(Response.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    // Decoding CoinImages from JSON data
    func fetchAllMoyaImages(withId: String, completion: @escaping ImagesMoyaCallback) {
        provider.request(.getCoinImages(coinsIds: withId)) { result in
            switch result {
            case let .success(response):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let results = try decoder.decode(ResponseImage.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
