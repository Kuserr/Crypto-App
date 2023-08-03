//
//  PortfolioListRow.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 01.08.2023.
//

import SwiftUI

struct PortfolioListRow: View {
    var coin: PortfolioCoinModel
    var body: some View {
        Label {
            Text( "\(coin.id) - \(coin.quantity)")
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    icon: {
        Image(coin.id)
            .resizable()
            .scaledToFit()
    }
    .frame(width: 330.0)
    }
}


struct PortfolioListRow_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioListRow(coin: PortfolioCoinModel(databaseObject: PortfolioCoin()))
    }
}
