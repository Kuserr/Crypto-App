//
//  CoinListRow.swift
//  Crypto_1_Edition
//
//  Created by Siarhei Kuryan on 29.06.2023.
//

import SwiftUI

struct CoinListRow: View {
    
    var coin: Coin

    var body: some View {
        Label {
            Text(coin.name) + Text(" (\(coin.shortName))").foregroundColor(Color.gray)
        }
    icon: {
        Image(coin.name)
            .resizable()
            .scaledToFit()
    }
    }
}

struct CoinListRow_Previews: PreviewProvider {
    static var previews: some View {
        CoinListRow(coin: Coin.coins.first!)
    }
}
