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
    @Published var imagesLoaded = false
    
    init() {
        loadData()
    }
    //MARK: - Private variables and functions
    
    private var networkLayer = NetworkLayer()
    private let BASE_URL = "https://pro-api.coinmarketcap.com"
    private let token: String = "c3cab33c-c6fa-4863-8f49-45091e5f5f5e"
    private var ids: [String] = []
    private var stringIds: String = ""
        //All ids as a String to make a request for logos
    private func idsAsString() {
            ids = allCoins.map {String($0.id)}
            stringIds = ids.map {String($0)}.joined(separator: ",")
        }
     
    private func loadData() {
            Task(priority: .high) {
                loadCoins()
            }
        }
    
    private func loadCoins() {
        networkLayer.fetchCoins { [weak self] result in
            switch result {
            case .success(let data):
                let result = data.data
                self?.allCoins = result
                self?.idsAsString()
                self?.loadImages()
            case .failure(_):
                return
            }
        }
    }
    
    private func loadImages() {
        networkLayer.fetchAllImages(stringId: stringIds) { [weak self] result in
            switch result {
            case .success(let data):
                let result = data.data
                self?.allImages = result
            case .failure(_):
                return
            }
        }
    }
    }

