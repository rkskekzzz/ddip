//
//  COREDATA_TEST_FUNC.swift
//  ProjectDDIP
//
//  Created by kyuhkim on 2021/09/22.
//

import Foundation

// MARK: - COREDATA_TEST

struct COREDATA_TEST {
    func AddDdip_TEST() {
        let id:Int64 = 8
        let title:String = "test8"
        let placeName:String = "eight"
        let la:Double = 37.524415113540215
        let lo:Double = 127.02942313110083
        let testDdipString:String = "{\"id\":\(id),\"title\":\(title),\"placeName\":\(placeName),\"startTime\":652897657.92252302,\"createTime\":652897557.92252302,\"remainSlot\":3,\"ddipToken\":\"ddipToken\",\"latitude\":\(la),\"longitude\":\(lo)}"
        print(testDdipString)
        
        print("-------------------")
        let code:Ddip = CoreDataManager.shared.toCoreData(entityName: ENTITY().ddip, jsonString: testDdipString)
        print(code.id)
        print(code.placeName)
    }

    func AddDdip_DUP_TEST() {
        let id:Int64 = 7
        let title:String = "test7"
        let placeName:String = "seven"
        let la:Double = 37.524415113540215
        let lo:Double = 127.02942313110083
        let testDdipString:String = "{\"id\":\(id),\"title\":\(title),\"placeName\":\(placeName),\"startTime\":652897657.92252302,\"createTime\":652897557.92252302,\"remainSlot\":3,\"ddipToken\":\"ddipToken\",\"latitude\":\(la),\"longitude\":\(lo)}"
        print(testDdipString)
        
        print("-------------------")
        let code:Ddip = CoreDataManager.shared.toCoreData(entityName: ENTITY().ddip, jsonString: testDdipString)
        print(code.id)
        print(code.placeName)
    }

    func TOJSON_TEST() {
        let coreData: [Ddip] = CoreDataManager.shared.fromCoreData(entityName: ENTITY().ddip)
        let jsonArray:String = CoreDataManager.shared.toJson(code: coreData)
        print(jsonArray)
    }

}
