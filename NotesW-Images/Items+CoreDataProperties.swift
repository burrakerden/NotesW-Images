//
//  Items+CoreDataProperties.swift
//  NotesW-Images
//
//  Created by Burak Erden on 28.02.2023.
//
//

import Foundation
import CoreData


extension Items {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Items> {
        return NSFetchRequest<Items>(entityName: "Items")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: String?
    @NSManaged public var id: UUID?
    @NSManaged public var size: String?
    @NSManaged public var image: Data?

}

extension Items : Identifiable {

}
