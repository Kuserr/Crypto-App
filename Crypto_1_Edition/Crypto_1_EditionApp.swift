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
            RootView()
                TabView {
                    CoinFullListView(dataService: PortfolioManager())
                        .tabItem {
                            Label("Cryptocurrencies", systemImage: "list.bullet")
                        }
                    FavouriteView(dataService: FavouritesManager(), viewModel: CoinFullListViewModel(dataService: NetworkManager()))
                        .tabItem {
                            Label("Favourites", systemImage: "star")
                        }
                    PortfolioView(dataService: PortfolioManager(), viewModel: CoinFullListViewModel(dataService: NetworkManager()))
                        .tabItem {
                            Label("Portfolio", systemImage: "chart.pie.fill")
                        }
                    SettingsView()
                        .tabItem {
                            Label("Settings", systemImage: "gear")
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
