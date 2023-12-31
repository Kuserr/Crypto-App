//
//  FavouriteRowView.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 23.10.2023.
//

import SwiftUI

struct FavouriteRowView: View {
    
    let coinImage: CoinImage
    let favCoin: FavouriteCoin
    let coinModel: CoinModel
    
    var body: some View {
        
        HStack {
            // cached images
            CachedImage(url: coinImage.logo)
            coinNameInfo
            .padding(.leading, 2)
            Spacer()
            coinPriceInfo
        }
        .padding(.horizontal)
    }
}

// MARK: - Coin name info
private extension FavouriteRowView {
    var coinNameInfo: some View {
        VStack(alignment: .leading, spacing: 1) {
            Text(favCoin.name)
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.leading, 4)
            Text(favCoin.symbol.uppercased())
                .font(.caption)
                .padding(.leading, 6)
        }
    }
}

// MARK: - Coin price info

private extension FavouriteRowView {
    var coinPriceInfo: some View {
        VStack(alignment: .trailing, spacing: 4) {
            Text(coinModel.quote.usd.price.toCurrency())
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.leading, 4)
            Text(coinModel.quote.usd.volumeChange24H.toPercentString())
                .font(.caption)
                .padding(.leading, 6)
                .foregroundColor(coinModel.quote.usd.percentChange24H > 0 ? .green : .red)
        }
    }
}
