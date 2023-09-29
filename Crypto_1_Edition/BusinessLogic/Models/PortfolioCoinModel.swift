//
//  PortfolioCoinModel.swift
//  Crypto_1_Edition
//
//  Created by Anton Marunko on 01.08.2023.
//

import Foundation

struct PortfolioCoinModel: Identifiable {
    var quantity: Double
    var shortId: String
    var id: String {
        return shortId
    }
    init(quantity: Double, shortId: String) {
        self.quantity = quantity
        self.shortId = shortId
    }

    init(databaseObject: PortfolioCoin) {
        self.quantity = databaseObject.quantity
        self.shortId = databaseObject.id
    }
}

extension PortfolioCoinModel: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(quantity)
    }
}
