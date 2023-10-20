//
//  MoyaViewModel.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 04.09.2023.
//

import Foundation
import Moya
import SwiftUI
import Combine

final class MoyaViewModel: ObservableObject {
    @Published var error: Error?
    @Published var moyaCoins: [CoinModel] = []
    @Published var moyaImages: [String: CoinImage] = [:]
    init() {
        loadMoyaCoins()
    }
    // MARK: - Private variables and functions
    private var stringIds: String = ""
    private var ids: [String] = []
    private let networkManager = NetworkManager()
    private func idAsString() {
        ids = moyaCoins.map {String($0.id)}
        stringIds = ids.map {String($0)}.joined(separator: ",")
    }
    
    private func loadMoyaCoins() {
        networkManager.fetchAllMoyaCoins { [weak self] result in
            switch result {
            case .success(let data):
                let result = data.data
                self?.moyaCoins = result
                self?.idAsString()
                self?.loadMoyaImages()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func loadMoyaImages() {
        networkManager.fetchAllMoyaImages(withId: stringIds) { [weak self] result in
            switch result {
            case .success(let data):
                let result = data.data
                self?.moyaImages = result
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
