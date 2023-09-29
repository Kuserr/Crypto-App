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
    init() {
        loadData()
    }
    // MARK: - Private variables and functions
    private var networkLayer = NetworkLayer()
    private var ids: [String] = []
    private var stringIds: String = ""
    // All ids as a String to make a request for CoinImages
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
