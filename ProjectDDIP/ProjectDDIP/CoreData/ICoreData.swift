//
//  ICoreData.swift
//  ProjectDDIP
//
//  Created by kyuhkim on 2021/09/23.
//

import Foundation

protocol ICoreData {
    func copy<T>(with: T)
    func getId() -> String
//    func getId() -> Int64
    func getDdipForm() -> DdipForm
    func getContractForm() -> ContractForm
}
