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

    func removeDuplicate(entityName: String) {
        let array:[NSManagedObject] = fromCoreData(entityName: entityName)
        guard !array.isEmpty else { return }
        var indexOut = 0
        var indexIn = 0
        
        for source in array {
            guard let convertedSource = source as? CopyDelegate else { assert(false) }
            
            for target in array {
                guard let convertedTarget = target as? CopyDelegate else { assert(false) }
                
                if indexOut < indexIn {
                    if convertedSource.getId() == convertedTarget.getId() {
                        deleteCoreData(entityName: entityName, object: target)
                        print("--> duplicate find! <--")
                    }
                }
                indexIn += 1
            }
            indexIn = 0
            indexOut += 1
        }
    }

    func deleteCoreData(entityName: String, id: Int64) {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = filteredRequest(id: id, entityName: entityName)
        do {
            if let results: [NSManagedObject] = try context?.fetch(fetchRequest) as? [NSManagedObject] {
                for item in results {
                    guard let convert = item as? CopyDelegate else { assert(false) }
                    
                    if convert.getId() == id {
                        context?.delete(item)
                        contextSave()
                        return
                    }
                }
            }
        } catch let error as NSError {
            print("Could not fatch: \(error), \(error.userInfo)")
        }
    }
    
    func deleteCoreData<T: NSManagedObject>(entityName: String, object: T) {
        guard let convert = object as? CopyDelegate else { assert(false) }
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = filteredRequest(id: convert.getId(), entityName: entityName)
        do {
            if let results: [T] = try context?.fetch(fetchRequest) as? [T] {
                if !results.isEmpty {
                    context?.delete(object)
                    print(results.count)
                    contextSave()
                }
            }
        } catch let error as NSError {
            print("Could not fatch: \(error), \(error.userInfo)")
        }
    }

    func fromCoreData<T> (entityName: String, ascendingKey: String = SYMBOL().EMPTY ) -> [T] {
        var array: [T] = []
        if let context = context {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
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
    
    func fromCoreData<T> (entityName: String, id: Int64) -> T? {
        let array:[T] = fromCoreData(entityName: entityName)
        guard !array.isEmpty else { return nil }
        
        for item in array {
            guard let convert = item as? CopyDelegate else { assert(false) }
            if convert.getId() == id { return item }
        }
        print("can not find id:[\(id)]")
        return nil
    }
    
    func toCoreData<T: Decodable> (entityName: String, jsonString: String) -> T {
        let decoder = JSONDecoder()
        decoder.userInfo[.managedObjectContext] = context
        do {
            let object = try decoder.decode(T.self, from: jsonString.data(using: .utf8)!)
            contextSave()
            removeDuplicate(entityName: entityName)
            return object
        } catch let error as NSError {
            print(error)
            assert(false)
        }
    }

    func toJson<T: Codable>(code: T) -> String {
        guard let data = try? JSONEncoder().encode(code) else { assert(false) }
        let json = String(data: data, encoding: String.Encoding.utf8)!
        return json
    }
}

private extension CoreDataManager {
    func filteredRequest(id: Int64, entityName: String) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id = %@", NSNumber(value: id))
        return fetchRequest
    }

    func contextSave() {
        do { try context?.save() }
        catch let error as NSError { print("Could not save: \(error), \(error.userInfo)") }
    }
}
