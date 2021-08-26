//
//  MapItemData.swift
//  ProjectDDIP
//
//  Created by su on 2021/08/26.
//

import Foundation

struct MapItemData: Encodable {
    
    var loc: Double
    var lloc: Double
    
    func getData() -> [AnyHashable:Any]  {
        let table = ["loc": loc,
                     "lloc": lloc] as [String : Any]
        return table
    }
}
