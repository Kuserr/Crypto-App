//
//  AboutCoinView.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 25.08.2023.
//

import SwiftUI

struct AboutCoinView: View {
    var coinModel: CoinModel
    var coinImage: CoinImage
    var urls: Urls
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    VStack {
                        AsyncImage(url: coinImage.imageUrl) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 45, height:45)
                                .foregroundColor(.red)
                        } placeholder: {
                            Circle()
                                .frame(width: 45, height:45)
                                .background(Color(.systemGray5))
                        }
                        Link(destination: URL(string:(urls.website).joined(separator: ""))!) {
                            Text(Image(systemName: "link.circle.fill")) + Text("Learn More")
                        }
                        Spacer()
                        Text(coinImage.description)
                            .multilineTextAlignment(.leading)
                    }
                } header: {
                    Text("What is \(coinModel.name)").fontWeight(.bold)
                }
            }
        }.navigationTitle("About \(coinModel.name)")
    }
}
