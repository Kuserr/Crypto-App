//
//  PortfolioRowView.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 24.10.2023.
//

import SwiftUI

struct PortfolioRowView: View {
    
    let coinImage: CoinImage
    let portfolioCoin: CryptoPortfolioCoin
    let coinModel: CoinModel
    @Binding var quantity: Double
    
    var body: some View {
        if portfolioCoin.quantity <= 0.0001 {
            HStack {
                // cached images
                CachedImage(url: coinImage.logo)
                // coin name info
                VStack(alignment: .leading, spacing: 1) {
                    Text(portfolioCoin.name)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.leading, 4)
                    Text(portfolioCoin.symbol.uppercased())
                        .font(.caption)
                        .padding(.leading, 6)
                }
                .padding(.leading, 2)
                Spacer()
                // coin price info
                VStack(alignment: .trailing) {
                    Text(String(portfolioCoin.quantity))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.leading, 4)
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal)
        } else {
            HStack {
                // cached images
                CachedImage(url: coinImage.logo)
                // coin name info
                VStack(alignment: .leading, spacing: 1) {
                    Text(portfolioCoin.name)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.leading, 4)
                    Text(portfolioCoin.symbol.uppercased())
                        .font(.caption)
                        .padding(.leading, 6)
                }
                .padding(.leading, 2)
                Spacer()
                // coin price info
                VStack(alignment: .trailing) {
                    Text(String(portfolioCoin.quantity))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.leading, 4)
                }
            }
            .padding(.horizontal)
        }
    }
}
