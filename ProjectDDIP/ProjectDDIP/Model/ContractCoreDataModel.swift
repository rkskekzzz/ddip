//
//  Contract+CoreDataClass.swift
//  ProjectDDIP
//
//  Created by kyuhkim on 2021/09/21.
//
//

import Foundation
import CoreData

@objc(Contract)
class Contract: NSManagedObject, Codable {
    enum CodingKeys: CodingKey {
        case id, ddipToken, userToken
    }

    required convenience init(from decoder: Decoder) throws {
        
        guard let context = decoder.userInfo[.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
    
        self.init(context: context)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int64.self, forKey: .id)
        ddipToken = try container.decode(String.self, forKey: .ddipToken)
        userToken = try container.decode(String.self, forKey: .userToken)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(ddipToken, forKey: .ddipToken)
        try container.encode(userToken, forKey: .userToken)
    }
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<Contract> {
        return NSFetchRequest<Contract>(entityName: ENTITY().contract)
    }
    
    @NSManaged var id: Int64
    @NSManaged var ddipToken: String
    @NSManaged var userToken: String
}

extension Contract: CopyDelegate {
    func copy<T>(with: T) {
        guard let convert = with as? Contract else { assert(false) }
        self.id = convert.id
        self.ddipToken = convert.ddipToken
        self.userToken = convert.userToken
    }
    
    func getId() -> Int64 { return self.id }
}

extension Contract : Identifiable {

}
