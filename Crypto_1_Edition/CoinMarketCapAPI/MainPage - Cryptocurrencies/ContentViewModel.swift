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
    @Published var error: Error?
    @Published var allCoins: [CoinModel] = []
    @Published var allImages: [String: CoinImage] = [:]
    let BASE_URL = "https://pro-api.coinmarketcap.com"
    let token: String = "c3cab33c-c6fa-4863-8f49-45091e5f5f5e"
    var ids: [String] = []
    var stringIds: String = ""
    @Published var imagesLoaded = false
    
    init() {
        loadData()
    }
    
    //MARK: - Async/Await code
  @MainActor
    func fetchCoinsAsync() async throws {
        var urlString: String {
            return  "\(BASE_URL)/v1/cryptocurrency/listings/latest?start=1&limit=100&sort=market_cap&cryptocurrency_type=all&tag=all"
        }
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
            self.allCoins = allCoins.data
            idsAsString()
            try await fetchAllImages()
        } catch {
            self.error = error
        }
    }
    
    //All ids as a String to make a request for logos
    func idsAsString() {
        ids = allCoins.map {String($0.id)}
        stringIds = ids.map {String($0)}.joined(separator: ",")
    }
    
    //Load Logos for Coins
    @MainActor
    func fetchAllImages() async throws {
        var urlString: String {
            return  "\(BASE_URL)/v2/cryptocurrency/info?id=\(stringIds)&aux=urls,logo,description"
        }
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
            guard let allImages = try? JSONDecoder().decode(ResponseImage.self, from: data) else {throw CoinError.invalidData}
            self.allImages = allImages.data
            self.imagesLoaded = true
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
