//
//  CoreDataItemRepository.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 18/05/21.
//

import CoreData

class CoreDataItemRepository: ItemRepository {
    
    func getAll() -> [ItemModel] {        
        var models = [ItemModel]()
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Item>(entityName: Constants.EntityName.item)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        do {
            let itens = try context.fetch(fetchRequest)
            for item in itens {
                if let model = EntityMapper.map(from: item, to: ItemModel.self) {
                    models.append(model)
                }
            }
            return models
            
        } catch let error as NSError {
            print("Erro ao recuperar itens: \(error), \(error.userInfo)")
        }
        
        return models
    }
    
    func save(_ data: ItemModel) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let fetchResult = fetch(byName: data.name, andValue: Int32(data.value))
        
        var item: Item
        if fetchResult != nil {
            item = fetchResult!
        } else {
            item = NSEntityDescription.insertNewObject(forEntityName: Constants.EntityName.item, into: context) as! Item
        }
        
        item.name = data.name
        item.value = Int32(data.value)
        
        if context.hasChanges {
            do {
                try context.save()
                print("Item salvo com sucesso.")
            } catch let error {
                print("Erro ao salvar item: \(error)")
            }
        }
    }
    
    private func fetch(byName name: String, andValue value: Int32) -> Item? {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Item>(entityName: Constants.EntityName.item)
        fetchRequest.predicate = NSPredicate(format: "name == %@ AND value == %i", name, value)
        fetchRequest.fetchLimit = 1
        
        do {
            let items = try context.fetch(fetchRequest)
            let item = items.first
            return item
        } catch let error {
            print("Erro ao recuperar item: \(error)")
        }
        
        return nil
    }
}
