//
//  Formats.swift
//  ProjectDDIP
//
//  Created by kyuhkim on 2021/08/26.
//

import Foundation

struct MapAnnotationData: Encodable {
    
    var name: String
    var loc: Double
    var lloc: Double
    var description: String
    
    func getData() -> [AnyHashable:Any]  {
        let table = ["name": name,
                     "loc": loc,
                     "lloc": lloc,
                     "description": description] as [String : Any]
        return table
    }
}
