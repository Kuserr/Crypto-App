//
//  CoinFullListView.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 18.08.2023.
//

import SwiftUI


struct CoinFullListView: View {
    @StateObject private var viewModels = ContentViewModel()
    @State private var results = [CoinModel]()
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModels.allCoins) { coin in
                    CoinRowView(coina: coin, coinImage: viewModels.allImages[String(coin.id)] ?? CoinImage.sample)
                }
            }
            .onReceive(viewModels.$error, perform: { error in
                if error != nil {
                    showAlert.toggle()
                }
            })
            .alert(isPresented: $showAlert, content: {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModels.error?.localizedDescription ?? "")
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

