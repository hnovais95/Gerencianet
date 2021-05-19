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
        
        do {
            let customers = try context.fetch(fetchRequest)
            for customer in customers {
                if let model = DataMapper.map(from: customer, to: CustomerModel.self) {
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
        
        let customer = NSEntityDescription.insertNewObject(forEntityName: Constants.EntityName.customer, into: context) as! Customer
        var juridicalPerson: JuridicalPerson?
        var address: Address?
        
        customer.name = data.name
        customer.cpf = data.cpf
        customer.birth = data.birth
        customer.phoneNumber = data.phoneNumber
        customer.email = data.email
        
        if data.juridicalPerson != nil {
            juridicalPerson = NSEntityDescription.insertNewObject(forEntityName: Constants.EntityName.juridicalPerson, into: context) as? JuridicalPerson
            customer.juridicalPerson = juridicalPerson
            customer.juridicalPerson?.corporateName = data.juridicalPerson?.corporateName
            customer.juridicalPerson?.cnpj = data.juridicalPerson?.cnpj
        }
        
        if data.address != nil {
            address = NSEntityDescription.insertNewObject(forEntityName: Constants.EntityName.address, into: context) as? Address
            customer.address = address
            customer.address?.street = data.address?.street
            customer.address?.number = data.address != nil ? Int16(data.address!.number) : 0
            customer.address?.complement = data.address?.complement
            customer.address?.neighborhood = data.address?.neighborhood
            customer.address?.city = data.address?.city
            customer.address?.zipCode = data.address?.zipCode
        }
        
        do {
            try CoreDataManager.shared.saveContext()
            print("Cliente salvo com sucesso.")
        } catch let error {
            print("Erro ao salvar cliente: \(error)")
        }
    }
}
