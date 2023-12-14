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
                coinNameInfo
                .padding(.leading, 2)
                Spacer()
                coinPriceInfo
            }
            .padding(.horizontal)
        } else {
            HStack {
                // cached images
                CachedImage(url: coinImage.logo)
                coinNameInfoElseCase
                .padding(.leading, 2)
                Spacer()
                // coin price info
                coinPriceInfoElseCase
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - Coin name info if portfolioCoin.quantity <= 0.0001

private extension PortfolioRowView {
    var coinNameInfo: some View {
        VStack(alignment: .leading, spacing: 1) {
            Text(portfolioCoin.name)
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.leading, 4)
            Text(portfolioCoin.symbol.uppercased())
                .font(.caption)
                .padding(.leading, 6)
        }
    }
}

// MARK: - Coin price info if portfolioCoin.quantity <= 0.0001

private extension PortfolioRowView {
    var coinPriceInfo: some View {
        VStack(alignment: .trailing) {
            Text(String(portfolioCoin.quantity))
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.leading, 4)
                .foregroundColor(.gray)
        }
    }
}

// MARK: - Coin name info else case

private extension PortfolioRowView {
    var coinNameInfoElseCase: some View {
        VStack(alignment: .leading, spacing: 1) {
            Text(portfolioCoin.name)
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.leading, 4)
            Text(portfolioCoin.symbol.uppercased())
                .font(.caption)
                .padding(.leading, 6)
        }
    }
}

// MARK: - Coin price info else case

private extension PortfolioRowView {
    var coinPriceInfoElseCase: some View {
        VStack(alignment: .trailing) {
            Text(String(portfolioCoin.quantity))
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.leading, 4)
        }
    }
}
