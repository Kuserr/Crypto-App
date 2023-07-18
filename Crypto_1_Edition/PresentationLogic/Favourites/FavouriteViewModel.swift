//
//  FavouriteViewModel.swift
//  Crypto_1_Edition
//
//  Created by Siarhei Kuryan on 04.07.2023.
//

import Foundation

final class FavouriteViewModel: ObservableObject {

    @Published var items = [Coin]()
   
    // MARK: - Private
    
    private var cdm = CoreDataManager()
    private var cdmItems = Set([Coin]())

    private func load() {
        cdmItems = Set(cdm.load().map({ Coin(databaseObject: $0)}))
    }
    
    private func updateUI() {
        items = Array(cdmItems)
    }

    func onAppear() {
        load()
        updateUI()
    }
}
