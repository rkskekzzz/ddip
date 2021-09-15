//
//  DdipManager.swift
//  ProjectDDIP
//
//  Created by kyuhkim on 2021/09/08.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared: CoreDataManager = CoreDataManager()
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    func getDataArray<T>(_ entityName: String, ascending: Bool = false) -> [T] {
        var models: [T] = [T]()
        
        if let context = context {
            let tokenSort: NSSortDescriptor = NSSortDescriptor(key: "id", ascending: ascending)
            let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest<NSManagedObject>(entityName: entityName)
            fetchRequest.sortDescriptors = [tokenSort]
            
            do {
                if let fetchResult: [T] = try context.fetch(fetchRequest) as? [T] {
                    models = fetchResult
                }
            } catch let error as NSError {
                print("Could not fetch: \(error), \(error.userInfo)")
            }
        }
        return models
    }

    func saveDdip(id: Int64, title: String, createTime:Date, startTime:Date, ddipToken:String, latitude:Double, longitude:Double, placeName:String, remainSlot:Int16, onSuccess: @escaping ((Bool) -> Void)) {
        if let context = context,
            let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Ddip", in: context) {

            if let ddip: Ddip = NSManagedObject(entity: entity, insertInto: context) as? Ddip {
                ddip.id = id
                ddip.title = title
                ddip.placeName = placeName
                ddip.remainSlot = remainSlot
                ddip.startTime = startTime
                ddip.createTime = createTime
                ddip.ddipToken = ddipToken
                ddip.latitude = latitude
                ddip.longitude = longitude

                contextSave { success in onSuccess(success) }
            }
        }
    }

    func saveContract(id: Int64, ddipToken:String, userToken:String, onSuccess: @escaping ((Bool) -> Void)) {
        if let context = context,
            let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Contract", in: context) {

            if let contract: Contract = NSManagedObject(entity: entity, insertInto: context) as? Contract {
                contract.id = id
                contract.ddipToken = ddipToken
                contract.userToken = userToken

                contextSave { success in onSuccess(success) }
            }
        }
    }

    func deleteDdip(id: Int64, onSuccess: @escaping ((Bool) -> Void)) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = filteredRequest(id: id, entityName: "Ddip")
        do {
            if let results: [Ddip] = try context?.fetch(fetchRequest) as? [Ddip] {
                if results.count != 0 {
                    context?.delete(results[0])
                }
            }
        } catch let error as NSError {
            print("Could not fatch: \(error), \(error.userInfo)")
            onSuccess(false)
        }
        contextSave { success in onSuccess(success) }
    }

    func deleteContract(id: Int64, onSuccess: @escaping ((Bool) -> Void)) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = filteredRequest(id: id, entityName: "Contract")
        do {
            if let results: [Contract] = try context?.fetch(fetchRequest) as? [Contract] {
                if results.count != 0 {
                    context?.delete(results[0])
                }
            }
        } catch let error as NSError {
            print("Could not fatch: \(error), \(error.userInfo)")
            onSuccess(false)
        }
        contextSave { success in onSuccess(success) }
    }

}

extension CoreDataManager {
    fileprivate func filteredRequest(id: Int64, entityName:String) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id = %@", NSNumber(value: id))
        return fetchRequest
    }

    fileprivate func contextSave(onSuccess: ((Bool) -> Void)) {
        do {
            try context?.save()
            onSuccess(true)
        } catch let error as NSError {
            print("Could not save: \(error), \(error.userInfo)")
            onSuccess(false)
        }
    }
}
