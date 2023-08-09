//
//  PortfolioListRow.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 01.08.2023.
//

import SwiftUI

struct PortfolioListRow: View {
    var pcm: PortfolioCoinModel
    var pvm: PortfolioViewModel
    var body: some View {
        Label {
            if pcm.quantity <= 0.0001 {Text( "\(pvm.fetchNameById(withId: pcm.id)) - \(pcm.id) - \(pcm.quantity)")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundColor(.gray)
            } else {
                Text( "\(pvm.fetchNameById(withId: pcm.id)) - \(pcm.id) - \(pcm.quantity)")
                        .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
        }
    icon: {
        Image(pcm.id)
            .resizable()
            .scaledToFit()
    }
    .frame(width: 330.0)
    }
}


struct PortfolioListRow_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioListRow(pcm: PortfolioCoinModel(databaseObject: PortfolioCoin()), pvm: PortfolioViewModel())
    }
}
