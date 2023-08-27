//
//  CoinDetailView.swift
//  Crypto_1_Edition
//
//  Created by Siarhei Kuryan on 29.06.2023.
//

import SwiftUI

struct CoinDetailView: View {
    @ObservedObject var viewModel: CoinDetailViewModel
    @State private var showingAlert = false
    @State private var alertForDelete = false
    
    var body: some View {
        Form {
            Section {
                VStack {
                    Image(viewModel.name)
                    Link(destination: viewModel.url) {
                        Text(Image(systemName: "link.circle.fill")) + Text("Learn More")
                                        }
                    Text(viewModel.descriptions)
                        .multilineTextAlignment(.leading)
                }
            } header: {
                Text(viewModel.aboutSectionTitle).fontWeight(.bold)
            }
            Section {
                Text(viewModel.foundersDescription)
            } header: {
                Text(viewModel.foundersSectionTitle).fontWeight(.bold)
            }

            Button("Add to fav") {viewModel.addId() }
            Button("Remove from fav") {viewModel.removeId() }
                .navigationBarTitle(viewModel.navigationBarTitle)
            
            Section { 
                Button("Add to Portfolio") {
                    showingAlert.toggle()
                }
                Button("Delete from Portfolio") {
                    alertForDelete.toggle()
                }
                .disabled(viewModel.checkQuantity() <= Double(0))
            }
        }
        .alert("How much coins of \(viewModel.shortName) you want to add?", isPresented: $showingAlert) {
            TextField("Enter the quantity", text: $viewModel.quantity)
                .keyboardType(.decimalPad)
            Button("Save", action: viewModel.updateCoin)
            Button("Cancel", role: .cancel) {}
        }
        .alert("You can delete max. \(viewModel.giveQuantity()) coins of \(viewModel.shortName).", isPresented: $alertForDelete) {
            TextField("Enter the quantity", text: $viewModel.quantity)
                .keyboardType(.decimalPad)
            Button("Save", action: viewModel.coinQuantityDel)
            Button("Cancel", role: .cancel) {}
        }
    } 
}


struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetailView(viewModel: CoinDetailViewModel(coin: Coin.coins.first!))
        
    }
}
