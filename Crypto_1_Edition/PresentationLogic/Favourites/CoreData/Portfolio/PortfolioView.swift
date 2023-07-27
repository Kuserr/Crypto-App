//
//  PortfolioView.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 24.07.2023.
//

import SwiftUI

struct PortfolioView: View {
    @StateObject var pvm: PortfolioViewModel
    @State private var showingAlert = false
    var body: some View {
        Form {
            Section {
                HStack {
                    Text("Coins")
                    Text("Quantity")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .frame(width: 330.0)
                List { ForEach(pvm.portfolioItems, id: \.self) { coin in
                        Label {
                        Text(coin.name) + Text(" (\(coin.shortName))").foregroundColor(Color.gray)
                        Text("100000")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    icon: {
                        Image(coin.name)
                            .resizable()
                            .scaledToFit()
                    }
                        .frame(width: 330.0)}
                    .onDelete(perform: removeRows)
                    .alert("Do you really want to delete this coin?", isPresented: $showingAlert) {
                        Button("Remove") { pvm.removePortfolioId()}
                        Button("Cancel", action: pvm.cancel)
                    }
                }
                .lineLimit(1)
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.961))
                
            }
        header: {
                Text("Portfolio")
                .frame(maxWidth: .infinity, alignment: .center)
            }
        .cornerRadius(25)
        }
        .onAppear(perform: pvm.onAppear)
    }
    
    
    func removeRows(at offsets: IndexSet) {
        showingAlert.toggle()
        pvm.portfolioItems.remove(atOffsets: offsets)
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView(pvm: PortfolioViewModel(coin: Coin.coins.first!))
    }
}

 
 
 
/*
struct PortfolioView: View {
    @ObservedObject var portfolioView: PortfolioViewModel
    var body: some View {
        Form {
            Section {
                HStack {
                    Text("Coins")
                    Text("Quantity").frame(maxWidth: .infinity, alignment: .trailing)
                }
                .frame(width: 330.0)
                    List { ForEach(portfolioView.portfolioItems) { coin in
                        Label {
                        Text(coin.name) + Text(" (\(coin.shortName))").foregroundColor(Color.gray)
                        Text("100000").frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    icon: {
                        Image(coin.name)
                            .resizable()
                            .scaledToFit()
                    }
                .frame(width: 330.0)}
                }
                .lineLimit(1)
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.961))
                
            }
        header: {
                Text("Portfolio").frame(maxWidth: .infinity, alignment: .center)
            }
        .cornerRadius(25)
        }.onAppear(perform: portfolioView.onAppear)
    }
}
*/
