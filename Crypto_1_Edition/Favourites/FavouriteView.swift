//
//  FavouriteView.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 22.10.2023.
//

import SwiftUI

struct FavouriteView: View {
    
    @ObservedObject var favVM: FavouriteViewModel
    @ObservedObject var viewModel: CoinFullListViewModel
    
    var body: some View {
        
            Form {
                Section {
                    ForEach(favVM.sortedCoins, id: \.id) { coin in
                        List {
                            FavouriteRowView(coinImage: viewModel.moyaImages[String(coin.id)] ?? CoinImage.sample, favCoin: coin, coinModel: viewModel.moyaCoins.first(where: {$0.name == coin.name}) ?? CoinModel.sample )
                        }
                    }
                    .onDelete(perform: favVM.swipeToRemove)
                }
            header: {
                Text("Favourites")
            }
            }
            .onAppear {
                favVM.onAppear()
            }
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView(favVM: FavouriteViewModel(), viewModel: CoinFullListViewModel())
    }
}
