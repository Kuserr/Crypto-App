//
//  FavouriteCoin.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 22.10.2023.
//

import Foundation
import CoreData

final class FavouriteCoin: NSManagedObject {
    @NSManaged public var name: String
    @NSManaged public var symbol: String
    @NSManaged public var id: String

    static func getAllFavCoinsRequest() -> NSFetchRequest<FavouriteCoin> {
        return NSFetchRequest<FavouriteCoin>(entityName: String(describing: FavouriteCoin.self))
    }
}
