//
//  CoinFullListView.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 18.08.2023.
//

import SwiftUI

struct CoinFullListView: View {
    @StateObject var viewModel = CoinFullListViewModel()
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.moyaCoins) { coin in
                    if let coinImage = viewModel.moyaImages[String(coin.id)] {
                    NavigationLink(destination:
                                    AboutCoinView(coinModel: coin,
                                                  coinImage: viewModel.moyaImages[String(coin.id)] ?? CoinImage.sample,
                                                  urls: coinImage.urls, viewModel: AboutCoinViewModel(coin: coin)),
                label: {
                        CoinRowView(
                            coina: coin,
                            coinImage: viewModel.moyaImages[String(coin.id)] ?? CoinImage.sample)})
                    } else {
                        // Show loading indicator if image is not yet fetched
                        HStack {
                            ActivityIndicator(style: .medium)
                            Text("Loading...")
                        }
                    }
                }
            }
            .onReceive(viewModel.$error, perform: { error in
                if error != nil {
                    showAlert.toggle()
                }
            })
            .alert(isPresented: $showAlert, content: {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.error?.localizedDescription ?? "")
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