//
//  Contract+CoreDataProperties.swift
//  ProjectDDIP
//
//  Created by kyuhkim on 2021/09/09.
//
//

import CoreData
import Foundation

public extension Contract {
    @nonobjc class func fetchRequest() -> NSFetchRequest<Contract> {
        return NSFetchRequest<Contract>(entityName: "Contract")
    }

    @NSManaged var ddipToken: String?
    @NSManaged var id: Int64
    @NSManaged var userToken: String?
}

extension Contract: Identifiable {}
