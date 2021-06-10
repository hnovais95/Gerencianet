//
//  SearchCustomerViewModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 27/05/21.
//

class SearchCustomerViewModel {
    
    // MARK: - Model
    
    let customerRepository = CoreDataCustomerRepository()
    
    
    // MARK: - Methods
    
    func getAllCustomers() -> [CustomerModel] {
        return customerRepository.getAll()
    }
}
