//
//  CoinsQuantity.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 24.07.2023.
//

import Foundation
import CoreData

final class CoinsQuantity: NSManagedObject {
    @NSManaged public var quantity: Decimal

    static func getAllCoinsQuantityRequest() -> NSFetchRequest<CoinsQuantity> {
        return NSFetchRequest<CoinsQuantity>(entityName: String(describing: CoinsQuantity.self))
    }
}
