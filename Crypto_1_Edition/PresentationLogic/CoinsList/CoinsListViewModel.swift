//
//  CoinsListViewModel.swift
//  Crypto_1_Edition
//
//  Created by Anton Marunko on 29.06.2023.
//

import Combine


final class CoinsListViewModel: ObservableObject {
    @Published var coins: [Coin] = Coin.coins
}