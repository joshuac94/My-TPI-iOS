//
//  JCCoreDataHelper.swift
//  My TPI
//
//  Created by Joshua Colley on 10/03/2018.
//  Copyright © 2018 Joshua Colley. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    func merge<T1: NSObject, T2: NSObject>(itemChanging:T1, itemToMerge:T2) {
        let mirrorSelf = Mirror(reflecting: itemChanging)
        let mirrorItemToMerge = Mirror(reflecting: itemToMerge)
        for mirrorSelfItem in mirrorSelf.children {
            // Loop through items in mirrorItemToMerge.
            for mirrorImageItem in mirrorItemToMerge.children {
                // If you have a parameter who's name is a match, map the value
                if mirrorSelfItem.label == mirrorImageItem.label {
                    // To set values, use self.setValue(valueToSet, forKey: propertyName)
                    self.setValue(mirrorImageItem.value, forKey: mirrorImageItem.label!)
                }
            }
        }
    }
}

class JCCoreDataHelper {

    func createEntity(delegate: AppDelegate, entityName: String) -> String {
        let context = delegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            return ""
        }
        let newObject = NSManagedObject(entity: entity, insertInto: context)
        let uuid = UUID().uuidString
        let today = Date().displayString()
        newObject.setValue(uuid, forKey: "inspectionID")
        newObject.setValue("Incomplete", forKey: "inspecionOutcome")
        newObject.setValue(today, forKey: "dateOfInspection")
        saveEntity(context: context)
        debugPrint("@Debug: Entity Created with ID: \(uuid)")
        return uuid
    }
    
    
    func saveEntity(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            return
        }
    }
    
    func fetchAllData(delegate: AppDelegate, entityName: String) -> [NSManagedObject] {
        let context = delegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        request.returnsObjectsAsFaults = false
        
        do {
            guard let result = try context.fetch(request) as? [NSManagedObject] else {
                return []
            }
            return result
        } catch {
            return []
        }
    }
    
    func fetchDataWithID(delegate: AppDelegate, entityName: String, id: String) -> [NSManagedObject] {
        let context = delegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        request.predicate = NSPredicate(format: "inspectionID = %@", id)
        request.returnsObjectsAsFaults = false
        
        do {
            guard let result = try context.fetch(request) as? [NSManagedObject] else {
                return []
            }
            return result
        } catch {
            return []
        }
    }
    
    func deleteEntity(delegate: AppDelegate, entityName: String, id: String) {
        let context = delegate.persistentContainer.viewContext
        let entity = fetchDataWithID(delegate: delegate, entityName: entityName, id: id)
        context.delete(entity[0])
    }
    
    func updateEntity(delegate: AppDelegate) {
        let context = delegate.persistentContainer.viewContext
        do { try context.save() } catch { debugPrint("Error Saving Data") }
    }
    
}
