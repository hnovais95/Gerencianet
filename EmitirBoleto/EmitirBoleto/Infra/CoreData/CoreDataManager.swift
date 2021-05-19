//
//  CoreDataManager.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 18/05/21.
//

import CoreData

class CoreDataManager {
    
    static var shared: CoreDataManager = {
        let instance = CoreDataManager()
        return instance
    }()
    
    let persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "EmitirBoleto")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    func saveContext() throws {
        let context = persistentContainer.viewContext
        try context.save()
    }
    
}

extension CoreDataManager: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
