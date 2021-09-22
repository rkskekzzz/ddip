//
//  Ddip+CoreDataClass.swift
//  ProjectDDIP
//
//  Created by kyuhkim on 2021/09/21.
//
//

import Foundation
import CoreData

@objc(Ddip)
class Ddip: NSManagedObject, Codable {

    private enum CodingKeys: CodingKey {
        case id, title, createTime, startTime, ddipToken, latitude, longitude, placeName, remainSlot
    //        case id, title, createTime, startTime, ddipToken, coordinate, placeName, remainSlot, coordinate
    }

    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int64.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        createTime = try container.decode(Date.self, forKey: .createTime)
        startTime = try container.decode(Date.self, forKey: .startTime)
        ddipToken = try container.decode(String.self, forKey: .ddipToken)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
        placeName = try container.decode(String.self, forKey: .placeName)
        remainSlot = try container.decode(Int16.self, forKey: .remainSlot)
    //        completions = try container.decode(Set<DdipCompletion>.self, forKey: .completions) as NSSet
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(createTime, forKey: .createTime)
        try container.encode(startTime, forKey: .startTime)
        try container.encode(ddipToken, forKey: .ddipToken)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(placeName, forKey: .placeName)
        try container.encode(remainSlot, forKey: .remainSlot)
    }

    @nonobjc class func fetchRequest() -> NSFetchRequest<Ddip> {
        return NSFetchRequest<Ddip>(entityName: ENTITY().ddip)
    }

    @NSManaged var id: Int64
    @NSManaged var createTime: Date
    @NSManaged var startTime: Date
    @NSManaged var title: String
    @NSManaged var placeName: String
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var remainSlot: Int16
    @NSManaged var ddipToken: String
}

extension Ddip: CopyDelegate {
    func copy<T>(with: T) {
        guard let convert = with as? Ddip else { assert(false) }
        
        self.id = convert.id
        self.createTime = convert.createTime
        self.startTime = convert.startTime
        self.title = convert.title
        self.placeName = convert.placeName
        self.latitude = convert.latitude
        self.longitude = convert.longitude
        self.remainSlot = convert.remainSlot
        self.ddipToken = convert.ddipToken
    }
    
    func getId() -> Int64 { return self.id }
}

extension Ddip : Identifiable {

}
