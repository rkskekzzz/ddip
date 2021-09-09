//
//  Contract+CoreDataProperties.swift
//  ProjectDDIP
//
//  Created by kyuhkim on 2021/09/09.
//
//

import Foundation
import CoreData


extension Contract {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contract> {
        return NSFetchRequest<Contract>(entityName: "Contract")
    }

    @NSManaged public var ddipToken: String?
    @NSManaged public var id: Int64
    @NSManaged public var userToken: String?

}

extension Contract : Identifiable {

}
