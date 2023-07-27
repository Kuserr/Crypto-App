//
//  MyCoins.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 24.07.2023.
//

import Foundation
import CoreData

final class MyCoins: NSManagedObject {
    @NSManaged public var descriptions: String
    @NSManaged public var foundersDescription: String
    @NSManaged public var name: String
    @NSManaged public var shortName: String
    @NSManaged public var url: URL
    @NSManaged public var id: String

    static func getAllMyCoinsRequest() -> NSFetchRequest<MyCoins> {
        return NSFetchRequest<MyCoins>(entityName: String(describing: MyCoins.self))
    }
}
