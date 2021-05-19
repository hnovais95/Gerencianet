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
        
        do {
            let itens = try context.fetch(fetchRequest)
            for item in itens {
                if let model = DataMapper.map(from: item, to: ItemModel.self) {
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
        
        let item = NSEntityDescription.insertNewObject(forEntityName: Constants.EntityName.item, into: context) as! Item
        
        item.name = data.name
        item.value = Int32(data.value)
        
        do {
            try CoreDataManager.shared.saveContext()
            print("Item salvo com sucesso.")
        } catch let error {
            print("Erro ao salvar item: \(error)")
        }
    }
}
