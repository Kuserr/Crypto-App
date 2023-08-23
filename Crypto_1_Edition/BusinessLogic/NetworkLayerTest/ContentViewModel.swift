//
//  ContentViewModel.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 18.08.2023.
//

import Foundation
import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var error: Error?
    let BASE_URL = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/map"
    var urlString: String {
        return  "\(BASE_URL)?start=1&limit=50&sort=cmc_rank"
    }
    
    init() {
        loadData()
    }
    
    //MARK: - Async/Await code
    @MainActor
    func fetchCoinsAsync() async throws {
        let token: String = "c3cab33c-c6fa-4863-8f49-45091e5f5f5e"
        guard let url = URL(string: urlString) else {
            print("DEBUG: Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("deflate, gzip", forHTTPHeaderField: "Accept-Encoding")
        request.httpMethod = "GET"
        request.addValue("\(token)", forHTTPHeaderField: "X-CMC_PRO_API_KEY")
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {throw CoinError.serverError }
            guard let allCoins = try? JSONDecoder().decode(Response.self, from: data) else {throw CoinError.invalidData}
            self.allCoins = (allCoins.data).reduce([]) {
                (result, element) in
                result.contains(element) ? result : result + [element]
            }
        } catch {
            self.error = error
        }
    }
    
    func loadData() {
        Task(priority: .medium) {
            try await fetchCoinsAsync()
        }
    }
}
/*
// MARK: - URLSession
    func fetchCoinsWithURLSession() {
        let token: String = "c3cab33c-c6fa-4863-8f49-45091e5f5f5e"
        guard let url = URL(string: urlString) else {
            print("DEBUG: Invalid URL")
            return
        }
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
                    self.error = CoinError.serverError
                    return
                }
                
                guard let data = data else {
                    print("DEBUG: Invalid data")
                    return
                }
                let decoder = JSONDecoder()
                guard let allCoins = try? decoder.decode(Response.self, from: data) else {
                    print("DEBUG: Could not decode coins!")
                    return
                }
                self.allCoins = (allCoins.data).reduce([]) { (result, element) in
                    result.contains(element) ? result : result + [element]
                }
            }
        }.resume()
    }
}
*/
