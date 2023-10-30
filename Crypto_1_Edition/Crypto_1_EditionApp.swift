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
                    CoinFullListView(viewModel: CoinFullListViewModel())
                        .tabItem {
                            Label("Cryptocurrencies", systemImage: "list.bullet")
                        }
                    FavouriteView(favVM: FavouriteViewModel(), viewModel: CoinFullListViewModel())
                        .tabItem {
                            Label("Favourites", systemImage: "star")
                        }
                    PortfolioView(viewModel: CoinFullListViewModel(), portfolioVM: PortfolioViewModel())
                        .tabItem {
                            Label("Portfolio", systemImage: "chart.pie.fill")
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
