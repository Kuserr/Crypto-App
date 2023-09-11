//
//  NetworkLayer.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 29.08.2023.
//

import Foundation
import SwiftUI
import Combine
import Moya

protocol NetworkLayerProtocol {
    func fetchAllImages(completion: @escaping ImagesCallback)
    func fetchAllCoins(completion: @escaping AllCoinsCallback)
}

typealias ImagesCallback = (Result<ResponseImage, CoinError>) -> Void
typealias AllCoinsCallback = (Result<Response, CoinError>) -> Void

final class NetworkLayer: ObservableObject {
    init() {
    }
    
    //Load CoinModels from API
    func fetchCoins(completion: @escaping AllCoinsCallback) {
        var urlString: String {
            return  "\(BASE_URL)/v1/cryptocurrency/listings/latest?start=1&limit=100&sort=market_cap&cryptocurrency_type=all&tag=all"
        }
        guard let url = URL(string: urlString) else {
            print("DEBUG: Invalid URL")
            return
        }
        cancellable?.cancel()
        cancellable = session.dataTaskPublisher(for: (urlRequest(withUrl: url))).tryMap() { element -> Data in
            guard let httpResponse = element.response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw CoinError.invalidURL
            }
            return element.data
        }
        .decode(type: Response.self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .sink { result in
            completion(.failure(.invalidData))
        } receiveValue: { result in
            completion(.success(result))
        }
    }
    
    //Load CoinImage from API
    func fetchAllImages(stringId: String, completion: @escaping ImagesCallback) {
        var urlString: String {
            return  "\(BASE_URL)/v2/cryptocurrency/info?id=\(stringId)&aux=urls,logo,description"
        }
        guard let url = URL(string: urlString) else {
            print("DEBUG: Invalid URL")
            return
        }
        cancellable?.cancel()
        cancellable = session.dataTaskPublisher(for: (urlRequest(withUrl: url))).tryMap() { element -> Data in
            guard let httpResponse = element.response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw CoinError.invalidURL
            }
            return element.data
        }
        .decode(type: ResponseImage.self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .sink { result in
            completion(.failure(.invalidData))
        } receiveValue: { result in
            completion(.success(result))
        }
    }
    //MARK: - Private
    private let BASE_URL = "https://pro-api.coinmarketcap.com"
    private let token: String = "c3cab33c-c6fa-4863-8f49-45091e5f5f5e"
    private let config: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        return config
    }()
    
    private lazy var session: URLSession = {
        let session = URLSession(configuration: config)
        return session
    }()
    
    private var cancellable: AnyCancellable?
    
    private func urlRequest(withUrl: URL) -> URLRequest{
        var request = URLRequest(url: withUrl)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("deflate, gzip", forHTTPHeaderField: "Accept-Encoding")
        request.httpMethod = "GET"
        request.addValue("\(token)", forHTTPHeaderField: "X-CMC_PRO_API_KEY")
        return request
    }
}
