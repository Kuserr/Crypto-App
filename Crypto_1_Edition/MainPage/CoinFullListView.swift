//
//  CoinFullListView.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 18.08.2023.
//

import SwiftUI

struct CoinFullListView: View {
    @StateObject var viewModel: CoinFullListViewModel
    @State private var showAlert = false
    
    init(dataService: PortfolioManager) {
        _viewModel = StateObject(wrappedValue: CoinFullListViewModel(dataService: NetworkManager()))
    }
    
    var body: some View {
        NavigationStack {
            list
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

// MARK: - List view
private extension CoinFullListView {
    var list: some View {
        List {
            ForEach(viewModel.moyaCoins) { coin in
                if let coinImage = viewModel.moyaImages[String(coin.id)] {
                NavigationLink(destination:
                                AboutCoinView(coinModel: coin,
                                              coinImage: viewModel.moyaImages[String(coin.id)] ?? CoinImage.sample,
                                              urls: coinImage.urls, viewModel: AboutCoinViewModel(coin: coin, dataService: PortfolioManager(), dataServiceFav: FavouritesManager())),
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
    }
}

struct CoinFullListView_Previews: PreviewProvider {
    static var previews: some View {
        CoinFullListView(dataService: PortfolioManager())
    }
}
