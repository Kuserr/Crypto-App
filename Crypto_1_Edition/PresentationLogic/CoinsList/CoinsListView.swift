//
//  ContentView.swift
//  Crypto_1_Edition
//
//  Created by Siarhei Kuryan on 25.06.2023.
//

import SwiftUI

struct CoinsListView: View {
    @ObservedObject var viewModel: CoinsListViewModel
    var body: some View {
        NavigationView {
            Form {
                Section {
                    ForEach(viewModel.coins, id: \.id) { coin in
                        NavigationLink(destination: CoinDetailView(
                            viewModel: CoinDetailViewModel(coin: coin)),
                                       label: { CoinListRow(coin: coin) })
                    }
                }
            header: {
                Text("Cryptocurrencies")
            }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CoinsListView(viewModel: CoinsListViewModel())
    }
}
