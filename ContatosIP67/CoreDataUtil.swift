//
//  CoreDataUtil.swift
//  ContatosIP67
//
//  Created by ios7649 on 7/5/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import Foundation
import CoreData

enum Entity: String {
    case contact = "Contact"
}

class CoreDataUtil <T> where T: NSManagedObject {
    
    let entity: Entity
    
    init(forEntity entity: Entity){
        self.entity = entity
    }
    
    
    //cria a entidade de modo que ela seja gerenciada pelo CoreData
    public func newManaged() -> T {
        return NSEntityDescription.insertNewObject(forEntityName: entity.rawValue, into: persistentContainer.viewContext) as! T

    }
    
    func remove(managedObject: T) {
        persistentContainer.viewContext.delete(managedObject)
    }
    
    func findAll() -> [T] {
        let request = NSFetchRequest<T>(entityName: entity.rawValue)
        
        //let orderByName = NSSortDescriptor(key: "name", ascending: true)
        //request.sortDescriptors = [ orderByName ]
        
        do{
            return try persistentContainer.viewContext.fetch(request)
        
        } catch let error as NSError {
            fatalError("Error to fetch data \(error.localizedDescription)")
        }
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "ContatosIP67")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    
    // MARK: - Core Data Saving support
    
    //func saveContext () {
    func commit () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    
    
}
