//
//  NetworkLayer.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 22.08.2023.
//
/*
import Foundation
import SwiftUI
import Combine


protocol NetworkLayerProtocol {
    func getCoins(completion: @escaping CoinsCallback)
}

typealias CoinsCallback = (Result<FetchCoinsResult, CoinError>) -> Void

final class NetworkLayer: NetworkLayerProtocol {
    
    private let BASE_URL = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/map"
    
    private var urlString: String {
        return  "\(BASE_URL)?start=1&limit=50&sort=id"
    }
    
    //private let config: URLSessionConfiguration = {
        //config.timeoutIntervalForRequest = 30
        //return config
    //}()
    
    //private lazy var session: URLSession = {
        //let session = URLSession(configuration: config)
        //return session
    //}()
    
    //private var cancellable: AnyCancellable?
    
    init() {
    }
    
    func getCoins(completion: @escaping CoinsCallback) {
        guard let url = URL(string: urlString) else {
            print("DEBUG: Invalid URL")
            return
        }
        
        let token: String = "c3cab33c-c6fa-4863-8f49-45091e5f5f5e"
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("deflate, gzip", forHTTPHeaderField: "Accept-Encoding")
        request.httpMethod = "GET"
        request.addValue("\(token)", forHTTPHeaderField: "X-CMC_PRO_API_KEY")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if let error = error {
                    print("DEBUG: Error \(error)")
                    return
                }
                
                guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                    print("DEBUG: Server Error")
                    return
                }
                
                guard let data = data else {
                    print("DEBUG: Invalid data")
                    return
                }
                
                guard let allCoins = try? JSONDecoder().decode([FetchCoinsResult].self, from: data) else {
                    print("DEBUG: Invalid data")
                    return
                }
                self.allCoins = allCoins
            }
        }
    }
}
*/
