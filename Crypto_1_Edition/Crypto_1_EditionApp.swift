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
                CoinFullListView(moyaViewModel: MoyaViewModel())
                    .tabItem {
                        Label("Cryptocurrencies", systemImage: "list.bullet")
                    }
                CoinsListView(viewModel: CoinsListViewModel())
                    .tabItem {
                        Label("Overview", systemImage: "list.clipboard")
                    }
                FavouritesView(clvm: FavouriteViewModel())
                    .tabItem {
                        Label("Favourites", systemImage: "star")
                    }
                PortfolioView(pvm: PortfolioViewModel())
                    .tabItem {
                        Label("Portfolio", systemImage: "chart.pie.fill")
                    }
                DelegateView(coinModelsVM: CoinModelsViewModel())
                    .tabItem {
                        Label("Test", systemImage: "list.clipboard")
                    }
                FactoryMethodView(factoryVM: FactoryViewModel())
                    .tabItem {
                        Label("Test", systemImage: "list.clipboard")
                    }
            }
        }
    }
}
