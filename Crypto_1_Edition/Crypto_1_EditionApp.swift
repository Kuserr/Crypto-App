//
//  Crypto_1_EditionApp.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 25.06.2023.
//

import SwiftUI
import FirebaseCore
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct Crypto_1_EditionApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
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
                        Label("Delegate", systemImage: "list.clipboard")
                    }
                FactoryMethodView(factoryVM: FactoryViewModel())
                    .tabItem {
                        Label("FactoryMethod", systemImage: "list.clipboard")
                    }
                CrashView()
                    .tabItem {
                        Label("CrashTest", systemImage: "chart.pie.fill")
                    }
                AnalyticsView()
                    .tabItem {
                        Label("AnalyticTest", systemImage: "star")
                    }
            }
        }
    }
}
