//
//  Crypto_1_EditionApp.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 25.06.2023.
//

import SwiftUI

@main
struct Crypto_1_EditionApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                CoinsListView(viewModel: CoinsListViewModel())
                    .tabItem {
                        Label("Overview", systemImage: "list.clipboard")
                    }
                FavouritesView(clvm: FavouriteViewModel())
                    .tabItem {
                        Label("Favourites", systemImage: "list.star")
                    }
                PortfolioView(pvm: PortfolioViewModel(), viewModel: CoinsListViewModel())
                    .tabItem {
                        Label("Portfolio", systemImage: "chart.pie.fill")
                    }
            }
        }
    }
}
