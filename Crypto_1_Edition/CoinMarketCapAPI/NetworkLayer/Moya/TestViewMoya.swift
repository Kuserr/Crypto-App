//
//  TestViewMoya.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 04.09.2023.
//

import SwiftUI

struct TestViewMoya: View {
    @StateObject var mvm = MoyaViewModel()
    var body: some View {
        List {
            ForEach(mvm.moyaCoins) {coin in
                Text("\(coin.name)")
                Text("\(mvm.moyaImages.description)")
            }
        }
    }
}

struct TestViewMoya_Previews: PreviewProvider {
    static var previews: some View {
        TestViewMoya()
    }
}

