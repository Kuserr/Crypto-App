//
//  CoinRowView.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 18.08.2023.
//

import SwiftUI

struct CoinRowView: View {
    let coina: CoinModel
    
    var body: some View {
        HStack {
            //market cap rank
            Text("\(coina.rank)")
                .font(.caption)
                .foregroundColor(.gray)
            // image
            /*
            AsyncImage(url: coina.imageUrl) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height:32)
                    .foregroundColor(.red)
            } placeholder: {
                Circle()
                    .frame(width: 32, height:32)
                    .background(Color(.systemGray5))
            }
             */
            //coin name info
            VStack(alignment: .leading, spacing: 4) {
                Text(coina.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.leading, 4)
                Text(coina.symbol.uppercased())
                    .font(.caption)
                    .padding(.leading, 6)
            }
            .padding(.leading, 2)
            Spacer()
            /*
            //coin price info
            VStack(alignment: .leading, spacing: 4) {
                Text(String(coina.price.toCurrency()))
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.leading, 4)
                Text(coina.percentChange24H.toPercentString())
                    .font(.caption)
                    .padding(.leading, 6)
                    .foregroundColor(coina.percentChange24H > 0 ? .green : .red)
            }
            .padding(.leading, 2)
            */
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}


struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coina: CoinModel.sample)
    }
}
