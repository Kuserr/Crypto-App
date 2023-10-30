//
//  CryptoPortfolioCoin.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 23.10.2023.
//

import Foundation
import CoreData

final class CryptoPortfolioCoin: NSManagedObject {
    @NSManaged public var quantity: Double
    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var symbol: String

    static func getAllCryptoPortfolioCoinRequest() -> NSFetchRequest<CryptoPortfolioCoin> {
        return NSFetchRequest<CryptoPortfolioCoin>(entityName: String(describing: CryptoPortfolioCoin.self))
    }
}
