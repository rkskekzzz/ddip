//
//  Ddip+CoreDataProperties.swift
//  ProjectDDIP
//
//  Created by kyuhkim on 2021/09/10.
//
//

import Foundation
import CoreData


extension Ddip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ddip> {
        return NSFetchRequest<Ddip>(entityName: "Ddip")
    }

    @NSManaged public var createTime: Date
    @NSManaged public var ddipToken: String
    @NSManaged public var id: Int64
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var placeName: String
    @NSManaged public var remainSlot: Int16
    @NSManaged public var startTime: Date
    @NSManaged public var title: String
}

extension Ddip : Identifiable {

}
