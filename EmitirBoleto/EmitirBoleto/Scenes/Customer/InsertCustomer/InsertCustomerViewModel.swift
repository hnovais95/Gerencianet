//
//  InsertCustomerViewModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 26/05/21.
//

import Foundation

class InsertCustomerViewModel {
    
    var name: String = ""
    var cpf: String = ""
    var corporateName: String = ""
    var cnpj: String = ""
    var phoneNumber: String = ""
    var email: String = ""
    var street: String = ""
    var number: Int?
    var complement: String = ""
    var neighborhood: String = ""
    var zipcode: String = ""
    var state: String = ""
    var city: String = ""
    
    var isJuridicalPerson: Bool = false
    var includeAddress: Bool = false    
    
    func getCustomer() -> CustomerModel {
        var juridicalPerson: JuridicalPersonModel?
        if isJuridicalPerson {
            juridicalPerson = JuridicalPersonModel(corporateName, cnpj)
        }
        
        var address: AddressModel?
        if includeAddress {
            address = AddressModel(street, number!, neighborhood, zipcode, city, complement, state)
        }
        
        return CustomerModel(name, cpf, phoneNumber, "2000-01-01", email, address, juridicalPerson)
    }
}
