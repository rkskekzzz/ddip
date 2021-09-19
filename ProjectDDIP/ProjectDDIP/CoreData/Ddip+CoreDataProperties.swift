//
//  Ddip+CoreDataProperties.swift
//  ProjectDDIP
//
//  Created by kyuhkim on 2021/09/10.
//
//

import CoreData
import Foundation

public extension Ddip {
    @nonobjc class func fetchRequest() -> NSFetchRequest<Ddip> {
        return NSFetchRequest<Ddip>(entityName: "Ddip")
    }

    @NSManaged var createTime: Date
    @NSManaged var ddipToken: String
    @NSManaged var id: Int64
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var placeName: String
    @NSManaged var remainSlot: Int16
    @NSManaged var startTime: Date
    @NSManaged var title: String
}

extension Ddip: Identifiable {}
