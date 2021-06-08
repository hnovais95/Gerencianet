//
//  CustomerRepository.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 18/05/21.
//

import CoreData

class CoreDataCustomerRepository: CustomerRepository {
    
    func getAll() -> [CustomerModel] {
        var models = [CustomerModel]()
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Customer>(entityName: Constants.EntityName.customer)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        do {
            let customers = try context.fetch(fetchRequest)
            for customer in customers {
                if let model = EntityMapper.map(from: customer, to: CustomerModel.self) {
                    models.append(model)
                }
            }
            return models
            
        } catch let error as NSError {
            print("Erro ao recuperar clientes: \(error), \(error.userInfo)")
        }
        
        return models
    }
    
    func save(_ data: CustomerModel) {        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let fetchResult = fetch(byCpf: data.cpf)
        
        var customer: Customer
        if fetchResult == nil {
            customer = NSEntityDescription.insertNewObject(forEntityName: Constants.EntityName.customer, into: context) as! Customer
        } else {
            customer = fetchResult!
        }
        
        customer.name = data.name
        customer.cpf = data.cpf
        customer.phoneNumber = data.phoneNumber
        customer.email = data.email
        
        var juridicalPerson: JuridicalPerson?
        if let _ = data.juridicalPerson {
            
            if fetchResult == nil {
                juridicalPerson = NSEntityDescription.insertNewObject(forEntityName: Constants.EntityName.juridicalPerson, into: context) as? JuridicalPerson
                customer.juridicalPerson = juridicalPerson
            }
            
            customer.juridicalPerson?.corporateName = data.juridicalPerson?.corporateName
            customer.juridicalPerson?.cnpj = data.juridicalPerson?.cnpj
        }
        
        var address: Address?
        if let _ =  data.address {
            
            if fetchResult == nil {
                address = NSEntityDescription.insertNewObject(forEntityName: Constants.EntityName.address, into: context) as? Address
                customer.address = address
            }
            
            customer.address?.street = data.address?.street
            customer.address?.number = data.address != nil ? Int16(data.address!.number) : 0
            customer.address?.complement = data.address?.complement
            customer.address?.neighborhood = data.address?.neighborhood
            customer.address?.city = data.address?.city
            customer.address?.zipCode = data.address?.zipCode
            customer.address?.state = data.address?.state
        }
        
        if context.hasChanges {
            do {
                try context.save()
                print("Cliente salvo com sucesso.")
            } catch let error {
                print("Erro ao salvar cliente: \(error)")
            }
        }
    }
    
    private func fetch(byCpf cpf: String) -> Customer? {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let customerfetchRequest = NSFetchRequest<Customer>(entityName: Constants.EntityName.customer)
        customerfetchRequest.predicate = NSPredicate(format: "cpf == %@", cpf)        
        customerfetchRequest.fetchLimit = 1
        
        do {
            let customers = try context.fetch(customerfetchRequest)
            let customer = customers.first
            return customer
        } catch let error {
            print("Erro ao recuperar cliente: \(error)")
        }
        
        return nil
    }
}
