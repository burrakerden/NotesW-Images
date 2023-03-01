//
//  Items+CoreDataProperties.swift
//  NotesW-Images
//
//  Created by Burak Erden on 1.03.2023.
//
//

import Foundation
import CoreData


extension Items {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Items> {
        return NSFetchRequest<Items>(entityName: "Items")
    }

    @NSManaged public var name: String?
    @NSManaged public var size: String?
    @NSManaged public var price: Double
    @NSManaged public var image: Data?
    @NSManaged public var id: UUID?

}

extension Items : Identifiable {

}
