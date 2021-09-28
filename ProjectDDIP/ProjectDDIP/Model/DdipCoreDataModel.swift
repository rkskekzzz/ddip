//
//  Ddip+CoreDataClass.swift
//  ProjectDDIP
//
//  Created by kyuhkim on 2021/09/21.
//
//

import Foundation
import CoreData

enum DecoderConfigurationError: Error {
    case missingManagedObjectContext
}

extension CodingUserInfoKey {
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

@objc(Ddip)
class Ddip: NSManagedObject {
    @nonobjc class func fetchRequest() -> NSFetchRequest<Ddip> {
        return NSFetchRequest<Ddip>(entityName: ENTITY().ddip)
    }

    @NSManaged var id: String
    @NSManaged var createTime: Date
    @NSManaged var startTime: Date
    @NSManaged var title: String
    @NSManaged var placeName: String
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var remainSlot: Int16
    @NSManaged var ddipToken: String
}

struct DdipForm: Codable {
    var id: String
    var createTime: Date
    var startTime: Date
    var title: String
    var placeName: String
    var latitude: Double
    var longitude: Double
    var remainSlot: Int16
    var ddipToken: String
}

extension Ddip: ICoreData {
    func copy<T>(with: T) {
        guard let convert = with as? DdipForm else { assert(false) }
        
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
    
    func getId() -> String { return self.id }
    
    func getDdipForm() -> DdipForm {
        return DdipForm(id: id, createTime: createTime, startTime: startTime, title: title, placeName: placeName, latitude: latitude, longitude: longitude, remainSlot: remainSlot, ddipToken: ddipToken)
    }
    
    func getContractForm() -> ContractForm {
        assert(false)
        return ContractForm(id: "", ddipToken: "", userToken: "")
    }
}

extension Ddip : Identifiable {

}
