//
//  FavouriteViewModel.swift
//  Crypto_1_Edition
//
//  Created by Siarhei Kuryan on 04.07.2023.
//

import Foundation

final class FavouriteViewModel: ObservableObject {
    
    @Published var items = [Coin]().sorted {
        $0.name > $1.name
    }
   
    // MARK: - Private
    
    private var cdm = CoreDataManager()
    private var cdmItems = Array(Set([Coin]()))

    private func load() {
        cdmItems = Array(Set(cdm.load().map({ Coin(databaseObject: $0)}))).sorted {
            $0.name > $1.name
        }
    }
    
    private func updateUI() {
        items = Array(cdmItems).sorted {
            $0.name > $1.name
        }
    }

    func onAppear() {
        load()
        updateUI()
    }
}
