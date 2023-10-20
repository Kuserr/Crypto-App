//
//  DelegateView.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 03.10.2023.
//

import SwiftUI

struct DelegateView: View {
    @StateObject var coinModelsVM = CoinModelsViewModel()
    
    var body: some View {
        List {
            ForEach(coinModelsVM.coinModels) { coin in
                Text("Coin name: \(coin.name)")
            }
        }
        .navigationBarItems(leading:
                            Button("Load") {coinModelsVM.showAll()},
                            trailing:
                            Button("Hide") {coinModelsVM.hideAll()

        })
    }
}

struct DelegateView_Previews: PreviewProvider {
    static var previews: some View {
        DelegateView()
    }
}
