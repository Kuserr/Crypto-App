//
//  FactoryMethodView.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 06.10.2023.
//

import SwiftUI

struct FactoryMethodView: View {
    
    @ObservedObject var factoryVM: FactoryViewModel
    
    var body: some View {
        List {
            ForEach(factoryVM.itemCoins, id: \.id) { coin in
                Text("Coin name: \(coin.topRating)")
            }
        }
    }
}

struct FactoryMethodView_Previews: PreviewProvider {
    static var previews: some View {
        FactoryMethodView(factoryVM: FactoryViewModel())
    }
}
