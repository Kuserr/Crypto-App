//
//  FavouriteViewModel.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 04.07.2023.
//

import Foundation

final class FavouriteViewModel: ObservableObject {
    private var db = Database()
    @Published var items = [Coin]()

    private var dbItems = Set<String>()

    // upd data for our view
    func onAppear() {
        load()
        updateUI()
    }

    // MARK: - Private

    private func load() {
        dbItems = db.load()
    }

    private func updateUI() {
        items = Coin.coins.filter { dbItems.contains($0.id) }
    }
}
