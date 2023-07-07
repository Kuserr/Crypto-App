//
//  FavouritesView.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 26.06.2023.
//

import SwiftUI

struct FavouritesView: View {
    @ObservedObject var clvm: FavouriteViewModel
    var body: some View {
        Form {
            Section {
                ForEach(clvm.items, id: \.id) { coin in
                    List { CoinListRow(coin: coin) }
                }
            }
        header: {
            Text("Favourites")
        }
        }.onAppear(perform: clvm.onAppear)
    }
}
struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView(clvm: FavouriteViewModel())
    }
}
