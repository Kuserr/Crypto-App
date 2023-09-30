//
//  CoinFullListView.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 18.08.2023.
//

import SwiftUI

struct CoinFullListView: View {
    // @StateObject private var viewModels = ContentViewModel()
    @StateObject var moyaViewModel = MoyaViewModel()
    @State private var showAlert = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(moyaViewModel.moyaCoins) { coin in
                    if let coinImage = moyaViewModel.moyaImages[String(coin.id)] {
                    NavigationLink(destination:
                                    AboutCoinView(coinModel: coin,
                                                  coinImage: moyaViewModel.moyaImages[String(coin.id)] ?? CoinImage.sample,
                                                  urls: coinImage.urls),
                label: {
                        CoinRowView(
                            coina: coin,
                            coinImage: moyaViewModel.moyaImages[String(coin.id)] ?? CoinImage.sample)})
                    } else {
                        // Show loading indicator if image is not yet fetched
                        HStack {
                            ActivityIndicator(style: .medium)
                            Text("Loading...")
                        }
                    }
                }
            }
            .onReceive(moyaViewModel.$error, perform: { error in
                if error != nil {
                    showAlert.toggle()
                }
            })
            .alert(isPresented: $showAlert, content: {
                Alert(
                    title: Text("Error"),
                    message: Text(moyaViewModel.error?.localizedDescription ?? "")
                )
            })
            .navigationTitle("Cryptocurrencies")
        }
    }
}

struct CoinFullListView_Previews: PreviewProvider {
    static var previews: some View {
        CoinFullListView()
    }
}
