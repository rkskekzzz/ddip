//
//  DdipManager.swift
//  ProjectDDIP
//
//  Created by kyuhkim on 2021/09/08.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    let entity: ENTITY = ENTITY()

    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
//    func deleteCoreData(entityName: String, id: UUID) {
    func deleteCoreData(entityName: String, id: Int64) {
        let result = fetchResult(id: id, entityName: entityName)
        if !result.isEmpty {
            for item in result { context?.delete(item) }
            contextSave()
        }
    }
    
    func deleteCoreData<T>(object: T) {
        guard let convert = object as? ICoreData else { assert(false) }
        deleteCoreData(entityName: getEntityName(typeArg: T.self), id: convert.getId())
    }

    func toCoreData<T> (jsonString: String) -> [T] {
        if T.self == Ddip.self {
            return toDdipCoreData(jsonString: jsonString)
        }
        if T.self == Contract.self {
            return toContractCoreData(jsonString: jsonString)
        }
        assert(false)
    }

    func fromCoreData<T> (ascendingKey: String = SYMBOL().EMPTY ) -> [T] {
        var array: [T] = []
        if let context = context {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: getEntityName(typeArg: T.self))
            if !ascendingKey.isEmpty {
                let sortByKey = NSSortDescriptor(key: ascendingKey, ascending: true)
                fetchRequest.sortDescriptors = [sortByKey]
            }
            do {
                if let fetchResult: [T] = try context.fetch(fetchRequest) as? [T] { array = fetchResult }
            } catch let error as NSError {
                print(error)
                assert(false)
            }
        }
        return array
    }

//    func fromCoreData<T> (id: UUID) -> [T] {
    func fromCoreData<T> (id: Int64) -> [T] {
        var array:[T] = []
        let fromCoreData:[T] = fromCoreData()
        
        for item in fromCoreData {
            guard let convert = item as? ICoreData else { assert(false) }
            if convert.getId() == id { array.append(item) }
        }
        return array
    }

    func toJson<T>(code: [T]) -> String {
        guard let convert = code as? [ICoreData] else { assert(false) }
        if T.self == Ddip.self {
            var array:[DdipForm] = []
            for item in convert {
                array.append(item.getDdipForm())
            }
            return toEncode(code: array)
        }
        if T.self == Contract.self {
            var array:[ContractForm] = []
            for item in convert {
                array.append(item.getContractForm())
            }
            return toEncode(code: array)
        }
        assert(false)
    }
    
    func fromJson<T: Decodable>(json: String) -> [T] {
        var array:[T] = []
        do {
            let result = try JSONDecoder().decode([T].self, from: json.data(using: .utf8)!)
            for item in result { array.append(item) }
            return array
        } catch let error as NSError {
            print(error)
            assert(false)
        }
    }
}

private extension CoreDataManager {
//    func filteredRequest(id: UUID, entityName: String) -> NSFetchRequest<NSFetchRequestResult> {
    func filteredRequest(id: Int64, entityName: String) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
//        fetchRequest.predicate = NSPredicate(format: "id = %@", id.uuidString)
        fetchRequest.predicate = NSPredicate(format: "id = %@", NSNumber(value: id))
        return fetchRequest
    }

//    func fetchResult(id: UUID, entityName: String) -> [NSManagedObject] {
    func fetchResult(id: Int64, entityName: String) -> [NSManagedObject] {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = filteredRequest(id: id, entityName: entityName)
        do {
            if let results: [NSManagedObject] = try context?.fetch(fetchRequest) as? [NSManagedObject] { return results }
            assert(false)
        } catch let error as NSError {
            print("Could not fatch: \(error), \(error.userInfo)")
            assert (false)
        }
    }

    func contextSave() {
        do { try context?.save() }
        catch let error as NSError { print("Could not save: \(error), \(error.userInfo)") }
    }

    func toEncode<T: Encodable>(code: [T]) -> String {
        guard let data = try? JSONEncoder().encode(code) else { assert(false) }
        let json = String(data: data, encoding: String.Encoding.utf8)!
        return json
    }

    func toDdipCoreData<T> (jsonString: String) -> [T] {
        var result:[T] = []
        let array:[DdipForm] = fromJson(json: jsonString)
        for item in array {
            let fetchResult = fetchResult(id: item.id, entityName: getEntityName(typeArg: T.self))
            if fetchResult.isEmpty {
                let append:[T] = appendCoreData(source: item)
                for obj in append {
                    result.append(obj)
                }
            }
        }
        if !result.isEmpty { contextSave() }
        else { print("nothing added") }
        return result
    }

    func toContractCoreData<T> (jsonString: String) -> [T] {
        var result:[T] = []
        let array:[ContractForm] = fromJson(json: jsonString)
        for item in array {
            let fetchResult = fetchResult(id: item.id, entityName: getEntityName(typeArg: T.self))
            if fetchResult.isEmpty {
                let append:[T] = appendCoreData(source: item)
                for obj in append {
                    result.append(obj)
                }
            }
        }
        if !result.isEmpty { contextSave() }
        else { print("nothing added") }
        return result
    }

    func appendCoreData<T1, T2> (source: T1) -> [T2] {
        if let context = context,
           let entity = NSEntityDescription.entity(forEntityName: getEntityName(typeArg: T2.self), in: context)
        {
            if let coreData: T2 = NSManagedObject(entity: entity, insertInto: context) as? T2 {
                guard let convert = coreData as? ICoreData else { assert(false) }
                convert.copy(with: source)
                return Array(arrayLiteral: coreData)
            }
        }
        assert(false)
    }

    func getEntityName<T>(typeArg: T) -> String {
        if T.self == Ddip.Type.self { return entity.ddip }
        if T.self == Contract.Type.self { return entity.contract }
        assert(false)
    }
}
