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

final class CoinFullListViewModel: ObservableObject {
    
    @Published var error: Error?
    @Published var moyaCoins: [CoinModel] = []
    @Published var moyaImages: [String: CoinImage] = [:]
    
    let dataService: NetworkManager
    
    init(dataService: NetworkManager) {
        self.dataService = dataService
        loadMoyaCoins()
    }
    
    // MARK: - Private variables and functions
    
    private var stringIds: String = ""
    private var ids: [String] = []
    private func idAsString() {
        ids = moyaCoins.map {String($0.id)}
        stringIds = ids.map {String($0)}.joined(separator: ",")
    }
    
    private func loadMoyaCoins() {
        dataService.fetchAllMoyaCoins { [weak self] result in
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
        dataService.fetchAllMoyaImages(withId: stringIds) { [weak self] result in
            switch result {
            case .success(let data):
                let result = data.data
                self?.moyaImages = result
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    // Functions for tests
    func downloadCoinModelsWithEscaping() {
        loadMoyaCoins()
    }
    
    func downloadImagesWithEscaping() {
        loadMoyaImages()
    }
}
