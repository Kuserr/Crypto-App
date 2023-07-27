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
    @State private var quantity = ""
    
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
                Button("Add") {viewModel.addPortfolioId()}
                Button("Remove") {viewModel.removePortfolioId()}
                Button("Add to Portfolio") {
                    showingAlert.toggle()
                }
                .alert("How much coins of \(viewModel.shortName) you want to add?", isPresented: $showingAlert) {
                    TextField("Enter the quantity", text: $quantity)
                        .keyboardType(.numberPad)
                    Button("Save", action: submit)
                    Button("Cancel", action: cancel)
                }
            }
        }
    }
    
    func submit() {
        print("\(quantity) coins of \(viewModel.shortName) was saved successfully!")
    }
    
    func cancel() {
        print("Operation was cancelled!")
    }
    
}



struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetailView(viewModel: CoinDetailViewModel(coin: Coin.coins.first!))
        
    }
}
