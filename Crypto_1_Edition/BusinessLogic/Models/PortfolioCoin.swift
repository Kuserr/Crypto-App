//
//  PortfolioCoin.swift
//  Crypto_1_Edition
//
//  Created by Anton Marunko on 01.08.2023.
//

import Foundation
import CoreData

final class PortfolioCoin: NSManagedObject {
    @NSManaged public var quantity: Double
    @NSManaged public var id: String

    static func getAllMyCoinsRequest() -> NSFetchRequest<PortfolioCoin> {
        return NSFetchRequest<PortfolioCoin>(entityName: String(describing: PortfolioCoin.self))
    }
}
