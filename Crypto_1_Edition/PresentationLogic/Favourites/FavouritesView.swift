//
//  FavouritesView.swift
//  Crypto_1_Edition
//
//  Created by Siarhei Kuryan on 26.06.2023.
//

import SwiftUI

struct FavouritesView: View {
    @ObservedObject var clvm: FavouriteViewModel
    var body: some View {
        Form {
            Section {
                ForEach(clvm.items) { coin in
                    List { Label {
                        Text(coin.name) + Text(" (\(coin.shortName))").foregroundColor(Color.gray)
                    }
                icon: {
                    Image(coin.name)
                        .resizable()
                        .scaledToFit()
                }}
                }
            }
        header: {
            Text("Favourites")
        }
        }.onAppear(perform: clvm.onAppear)
    }
}

//struct FavouritesView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavouritesView(clvm: FavouriteViewModel(coinss: Coin()))
//    }
//}
