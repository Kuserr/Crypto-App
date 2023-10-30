//
//  AboutCoinView.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 25.08.2023.
//

import SwiftUI

struct AboutCoinView: View {
    
    @Environment(\.presentationMode) var presentationMode
    var coinModel: CoinModel
    var coinImage: CoinImage
    var urls: Urls
    
    @ObservedObject var viewModel: AboutCoinViewModel
    @State private var showingAlert = false
    @State private var alertForDelete = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    VStack {
                        Spacer()
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
                    Text("What is \(coinModel.name)?").fontWeight(.bold)
                }
                
                Section {
                    Button("Add to favourites") {viewModel.addToFavourite()}
                    Button("Remove from favourites") {viewModel.removeFromFavourite()}
                }
                
                Section {
                    Button("Add to Portfolio") { showingAlert.toggle()
                    }
                    Button("Delete from Portfolio") { alertForDelete.toggle()
                    }
                    .disabled(viewModel.checkCoinQuantity() <= Double(0))
                }
            }
            .alert("How much coins of \(coinModel.symbol) you want to add?", isPresented: $showingAlert) {
                TextField("Enter the quantity", text: $viewModel.quantity)
                    .keyboardType(.decimalPad)
                Button("Save") {
                    viewModel.updateCoin()
                    viewModel.quantity = ""
                    presentationMode.wrappedValue.dismiss()
                }
                Button("Cancel", role: .cancel) {}
            }
            .alert("You can delete max. \(viewModel.giveQuantity()) coins of \(coinModel.name).", isPresented: $alertForDelete) {
                TextField("Enter the quantity", text: $viewModel.quantity)
                    .keyboardType(.decimalPad)
                Button("Save") {
                    viewModel.coinQuantityDel()
                    viewModel.quantity = ""
                    presentationMode.wrappedValue.dismiss()
                }
                Button("Cancel", role: .cancel) {}
            }
        }.navigationTitle("About \(coinModel.name)")
    }
}
