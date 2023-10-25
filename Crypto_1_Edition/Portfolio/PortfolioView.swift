//
//  PortfolioView.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 23.10.2023.
//

import SwiftUI

struct PortfolioView: View {
    
    @ObservedObject var viewModel: CoinFullListViewModel
    @ObservedObject var portfolioVM: PortfolioViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    List {
                        ForEach(portfolioVM.portfCoins, id: \.id) { coin in
                            if let index = portfolioVM.portfCoins.firstIndex(where: { $0.id == coin.id }) {
                                PortfolioRowView(coinImage: viewModel.moyaImages[String(coin.id)] ?? CoinImage.sample,
                                                 portfolioCoin: portfolioVM.portfCoins[index],
                                                 coinModel: viewModel.moyaCoins.first(where: { String($0.id) == coin.id }) ?? CoinModel.sample,
                                                 quantity: $portfolioVM.portfCoins[index].quantity)
                                .deleteDisabled(coin.quantity != Double(0))
                            }
                        }
                        .onDelete(perform: portfolioVM.swipeToRemove)}
                    .lineLimit(1)
                    .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.961))
                }
            header: {
                Text("Portfolio")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .cornerRadius(25)
            }
            .onAppear(perform: portfolioVM.onAppear)
        }
    }
}
