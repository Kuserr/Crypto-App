//
//  PortfolioView.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 24.07.2023.
//

import SwiftUI

struct PortfolioView: View {
    @StateObject var pvm: PortfolioViewModel
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Coins")
                        Text("Quantity")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .frame(width: 306.0)
                    List {
                        ForEach(pvm.portfolioItems, id: \.id) { coin in
                            NavigationLink(destination: CoinDetailView(viewModel: CoinDetailViewModel(coin: pvm.giveMeCoin(withId: coin.shortId)!)),
                            label: {PortfolioListRow(pcm: PortfolioCoinModel(quantity: coin.quantity, shortId: coin.shortId), pvm: PortfolioViewModel())})
                        .deleteDisabled(coin.quantity != 0)
                        }
                        .onDelete(perform: pvm.removeRows)
                    }
                    .lineLimit(1)
                    .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.961))
                }
            header: {
                Text("Portfolio")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .cornerRadius(25)
            }
            .onAppear(perform: pvm.onAppear)
        }
    }
    }

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView(pvm: PortfolioViewModel())
    }
}
