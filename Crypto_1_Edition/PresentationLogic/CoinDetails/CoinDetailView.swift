//
//  CoinDetailView.swift
//  Crypto_1_Edition
//
//  Created by Siarhei Kuryan on 29.06.2023.
//

import SwiftUI

struct CoinDetailView: View {
    @ObservedObject var viewModel: CoinDetailViewModel
    var body: some View {
        Form {

            Section {
                VStack {
                    Image(viewModel.name)
                    Link(destination: viewModel.url) {
                        Text(Image(systemName: "link.circle.fill")) + Text("Learn More")
                    }
                    
                    Text(viewModel.descriptions)
                        .multilineTextAlignment(.leading)
                }
            } header: {
                Text(viewModel.aboutSectionTitle).fontWeight(.bold)
            }
            Section {
                Text(viewModel.foundersDescription)
            } header: {
                Text(viewModel.foundersSectionTitle).fontWeight(.bold)
            }

            Button("Add to fav") {viewModel.addId() }
            
            Button("Remove from fav") {viewModel.removeId() }
            
                .navigationBarTitle(viewModel.navigationBarTitle)
        }
    }
    
}


struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetailView(viewModel: CoinDetailViewModel(coin: Coin.coins.first!))
        
    }
}
