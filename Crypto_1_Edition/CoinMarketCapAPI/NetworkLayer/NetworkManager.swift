//
//  NetworkManager.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 31.08.2023.
//

import Foundation
import Moya


final class NetworkManager {
    func fetchesCoins() {
        provider.request(.getCoinModels) { result in
            switch result {
            case .success(let response):
                print(String.init(data: response.data, encoding: .utf8))
            case .failure(let error):
                print(error)
            }
        }
    }
}

    
/*
protocol Networkable {
    //var provider: MoyaProvider<NetworkTarget>{get}
    func fetchesCoins(completion: @escaping (Result<Response, Error>) -> ())
}
typealias MoyaCallback = (Result<Response, CoinError>) -> Void
let token = "c3cab33c-c6fa-4863-8f49-45091e5f5f5e"
let authPlugin = AccessTokenPlugin {_ in token }
var provider = MoyaProvider<NetworkTarget>(plugins: [authPlugin])

class NetworkManager: Networkable {
    //var provider = MoyaProvider<NetworkTarget>(plugins: [NetworkLoggerPlugin()])
    
    func fetchesCoins(completion: @escaping (Result<Response, Error>) -> ()) {
        request(target: .getCoinModels, completion: completion)
    }
}

private extension NetworkManager {
    private func request<Response: Decodable>(target: NetworkTarget, completion: @escaping (Result<Response, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(Response.self, from: response.data)
                    completion(.success(results))
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
*/
