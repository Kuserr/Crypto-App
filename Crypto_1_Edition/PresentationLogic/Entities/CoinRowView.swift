//
//  CoinRowView.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 18.08.2023.
//

import SwiftUI

struct CoinRowView: View {
    let coina: CoinModel
    let coinImage: CoinImage
    
    var body: some View {
        HStack {
            marketCapRank
            // cached images
            CachedImage(url: coinImage.logo)
            coinNameInfo
            .padding(.leading, 2)
            Spacer()
            coinPriceInfo
            .padding(.leading, 2)
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}
// MARK: - Market Cap Rank

private extension CoinRowView {
    
    var marketCapRank: some View {
        Text("\(coina.cmcRank)")
            .font(.caption)
            .foregroundColor(.gray)
    }
}

// MARK: - Coin name info

private extension CoinRowView {
    var coinNameInfo: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(coina.name)
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.leading, 4)
            Text(coina.symbol.uppercased())
                .font(.caption)
                .padding(.leading, 6)
        }
    }
}

// MARK: - Coin price info

private extension CoinRowView {
    var coinPriceInfo: some View {
        VStack(alignment: .trailing, spacing: 4) {
            Text(coina.quote.usd.price.toCurrency())
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.leading, 4)
            Text(coina.quote.usd.volumeChange24H.toPercentString())
                .font(.caption)
                .padding(.leading, 6)
                .foregroundColor(coina.quote.usd.percentChange24H > 0 ? .green : .red)
        }
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coina: CoinModel.sample, coinImage: CoinImage.sample)
    }
}
