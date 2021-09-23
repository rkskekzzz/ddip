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
class Contract: NSManagedObject {
    @nonobjc class func fetchRequest() -> NSFetchRequest<Contract> {
        return NSFetchRequest<Contract>(entityName: ENTITY().contract)
    }

    @NSManaged var id: Int64
    @NSManaged var ddipToken: String
    @NSManaged var userToken: String
}

struct ContractForm: Codable {
    var id: Int64
    var ddipToken: String
    var userToken: String
}

extension Contract: CopyDelegate {
    
    func copy<T>(with: T) {
        guard let convert = with as? ContractForm else { assert(false) }
        self.id = convert.id
        self.ddipToken = convert.ddipToken
        self.userToken = convert.userToken
    }
    
    func getId() -> Int64 { return self.id }

    func getDdipForm() -> DdipForm {
        assert(false)
        return DdipForm(id: 0, createTime: Date(), startTime: Date(), title: "", placeName: "", latitude: 0, longitude: 0, remainSlot: 0, ddipToken: "")
    }

    func getContractForm() -> ContractForm {
        return ContractForm(id: id, ddipToken: ddipToken, userToken: userToken)
    }
}

extension Contract : Identifiable {

}
