//
//  TEST_CORE_DATA.swift
//  ProjectDDIP
//
//  Created by kyuhkim on 2021/09/23.
//

import Foundation

class TEST_CORE_DATA {
    func AddDdip_TEST(id: Int64, title: String, placeName: String, la: Double, lo: Double) {
        let id:Int64 = id
        let title:String = title
        let placeName:String = placeName
        let la:Double = la
        let lo:Double = lo
//        let id:Int64 = 10
//        let title:String = "test10"
//        let placeName:String = "ten"
//        let la:Double = 37.624415113540215
//        let lo:Double = 127.12942313110083
        let testDdipString:String = "[{\"id\":\(id),\"title\":\"\(title)\",\"placeName\":\"\(placeName)\",\"startTime\":652897657.92252302,\"createTime\":652897557.92252302,\"remainSlot\":3,\"ddipToken\":\"ddipToken\",\"latitude\":\(la),\"longitude\":\(lo)}]"
        print(testDdipString)
        print("-------------------!!!0")
        let obj:[DdipForm] = CoreDataManager.shared.fromJson(json: testDdipString)
        for item in obj {
            print(item.id)
            print(item.placeName)
        }

        print("-------------------!!!1")
        let code:[Ddip] = CoreDataManager.shared.toCoreData(jsonString: testDdipString)
        for item in code {
            print(item.id)
            print(item.placeName)
        }
    }

    func AddDdip_DUP_TEST() {
        let id:Int64 = 11
        let title:String = "test11"
        let placeName:String = "eleven"
        let la:Double = 37.54184581847791
        let lo:Double = 127.03724921912465
        let testDdipString:String = "[{\"id\":\(id),\"title\":\"\(title)\",\"placeName\":\"\(placeName)\",\"startTime\":652897657.92252302,\"createTime\":652897557.92252302,\"remainSlot\":3,\"ddipToken\":\"ddipToken\",\"latitude\":\(la),\"longitude\":\(lo)}]"
        print(testDdipString)
        
        print("-------------------")
        let code:[Ddip] = CoreDataManager.shared.toCoreData(jsonString: testDdipString)
        for item in code {
            print(item.id)
            print(item.placeName)
        }
        print("- - - - - - - - - - - - - - - - - -")
        let dup:[Ddip] = CoreDataManager.shared.toCoreData(jsonString: testDdipString)
        for item in dup {
            print(item.id)
            print(item.placeName)
        }
    }

    func TOJSON_TEST() {
        let coreData: [Ddip] = CoreDataManager.shared.fromCoreData()
        let jsonArray:String = CoreDataManager.shared.toJson(code: coreData)
        print(jsonArray)
    }
    
//    func FROMJSON_TEST() {
//        let id:Int64 = 9
//        let title:String = "test9"
//        let placeName:String = "nine"
//        let la:Double = 37.5307749196663
//        let lo:Double = 127.02579994220088
//        let testDdipString:String = "[{\"id\":\(id),\"title\":\"\(title)\",\"placeName\":\"\(placeName)\",\"startTime\":652897657.92252302,\"createTime\":652897557.92252302,\"remainSlot\":3,\"ddipToken\":\"ddipToken\",\"latitude\":\(la),\"longitude\":\(lo)}]"
//
//        let data:[DdipForm] = CoreDataManager.shared.fromJson(json: testDdipString)
//        for item in data {
//            print(item.id)
//            print(item.placeName)
//        }
//        let tt:[Ddip] = CoreDataManager.shared.fromCoreData(id:8)
//        let st = CoreDataManager.shared.toJson(code: tt)
//        print(st)
//    }
    
    func FROMJSONARRAY_TEST() {
        let code:[Ddip] = CoreDataManager.shared.fromCoreData()
        let jsonArray = CoreDataManager.shared.toJson(code: code)
        let data:[DdipForm] = CoreDataManager.shared.fromJson(json: jsonArray)
        for item in data {
            print(item.id)
            print(item.placeName)
        }
        let st = CoreDataManager.shared.toJson(code: code)
        print(st)
    }
    
//    func DELETE_TEST() {
//        CoreDataManager.shared.deleteCoreData(entityName: ENTITY().ddip, id: 7)
//    }
}
