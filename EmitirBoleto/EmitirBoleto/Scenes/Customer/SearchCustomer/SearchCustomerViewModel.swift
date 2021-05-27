//
//  SearchCustomerViewModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 27/05/21.
//

class SearchCustomerViewModel {
    
    let customerRepository = CoreDataCustomerRepository()
    
    func getAllCustomers() -> [CustomerModel] {
        return customerRepository.getAll()
    }
}
