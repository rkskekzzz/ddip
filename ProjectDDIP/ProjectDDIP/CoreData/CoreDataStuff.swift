//
//  DdipDataForm.swift
//  ProjectDDIP
//
//  Created by kyuhkim on 2021/09/21.
//

import Foundation
import CoreData

enum DecoderConfigurationError: Error {
    case missingManagedObjectContext
}

extension CodingUserInfoKey {
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

protocol CopyDelegate {
    func copy<T>(with: T)
    func getId() -> Int64
    func getDdipForm() -> DdipForm
    func getContractForm() -> ContractForm
}
