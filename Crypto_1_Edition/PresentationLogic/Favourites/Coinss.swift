//
//  Coinss.swift
//  Crypto_1_Edition
//
//  Created by Siarhei Kuryan on 17.07.2023.
//

import Foundation
import CoreData

final class Coinss: NSManagedObject {
    @NSManaged public var descriptions: String
    @NSManaged public var foundersDescription: String
    @NSManaged public var name: String
    @NSManaged public var shortName: String
    @NSManaged public var url: URL

    static func getAllCoinsRequest() -> NSFetchRequest<Coinss> {
        return NSFetchRequest<Coinss>(entityName: String(describing: Coinss.self))
    }
}
