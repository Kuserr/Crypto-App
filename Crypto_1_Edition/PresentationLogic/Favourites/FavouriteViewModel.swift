//
//  FavouriteViewModel.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 04.07.2023.
//

import SwiftUI

struct FavouritesView: View {
    @ObservedObject var clvm: FavouriteViewModel
    var body: some View {
        Form {
            Section {
                ForEach(clvm.items) { coin in
                    List { Label {
                        Text(clvm.name) + Text(" (\(clvm.shortName))").foregroundColor(Color.gray)
                    }
                icon: {
                    Image(clvm.name)
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
struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView(clvm: FavouriteViewModel(coinss: Coinss()))
    }
}

