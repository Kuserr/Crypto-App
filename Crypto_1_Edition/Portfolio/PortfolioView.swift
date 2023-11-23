//
//  PortfolioView.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 23.10.2023.
//

import SwiftUI

struct PortfolioView: View {
    
    @ObservedObject var viewModel: CoinFullListViewModel
    @StateObject private var portfolioVM: PortfolioViewModel
    
    init(dataService: PortfolioManager, viewModel: CoinFullListViewModel) {
        _portfolioVM = StateObject(wrappedValue: PortfolioViewModel(dataService: dataService))
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    List {
                        ForEach(portfolioVM.portfolioCoins, id: \.id) { coin in
                            if let index = portfolioVM.portfolioCoins.firstIndex(where: { $0.id == coin.id }) {
                                PortfolioRowView(coinImage: viewModel.moyaImages[String(coin.id)] ?? CoinImage.sample,
                                                 portfolioCoin: portfolioVM.portfolioCoins[index],
                                                 coinModel: viewModel.moyaCoins.first(where: { String($0.id) == coin.id }) ?? CoinModel.sample,
                                                 quantity: $portfolioVM.portfolioCoins[index].quantity)
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
