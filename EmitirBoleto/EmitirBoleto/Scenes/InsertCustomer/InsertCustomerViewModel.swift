//
//  InsertCustomerViewModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 26/05/21.
//

import Foundation

class InsertCustomerViewModel {
    
    let validator = CustomerValidator()
    
    var name: String = ""
    var cpf: String = ""
    var corporateName: String = ""
    var cnpj: String = ""
    var phoneNumber: String = ""
    var email: String = ""
    var street: String = ""
    var number: String = ""
    var complement: String = ""
    var neighborhood: String = ""
    var zipcode: String = ""
    var state: String = ""
    var city: String = ""
    var isJuridicalPerson: Bool = false
    var includeAddress: Bool = false
    
    var validatedField: (Bool, Int) -> () = { _,_  in }
    
    func validadeField(_ rawValue: Int, value: String) {
        let isValid = validator.validate(rawValue, value)
        validatedField(isValid, rawValue)
    }
    
    func getCustomer() -> CustomerModel {
        var juridicalPerson: JuridicalPersonModel?
        if isJuridicalPerson {
            juridicalPerson = JuridicalPersonModel(corporateName, cnpj)
        }
        
        var address: AddressModel?
        if includeAddress {
            let complement: String? = !self.complement.isEmpty ? self.complement : nil // complement is optional
            address = AddressModel(street, Int(number)!, neighborhood, zipcode, city, complement, state)
        }
        
        let email: String? = !self.email.isEmpty ? self.email : nil // email is optional
        return CustomerModel(name, cpf, phoneNumber, email, address, juridicalPerson)
    }
    
    var isValid: Bool {
        var isValidJuridicalPerson: Bool {
            if isJuridicalPerson {
                return validator.validate(.corporateName, corporateName)
                    && validator.validate(.cnpj, cnpj)
            } else {
                return true
            }
        }
        
        var isValidAddress: Bool {
            if includeAddress {
                return validator.validate(.street, street)
                    && validator.validate(.number, number)
                    && validator.validate(.complement, complement)
                    && validator.validate(.neighborhood, neighborhood)
                    && validator.validate(.zipcode, zipcode)
                    && validator.validate(.state, state)
                    && validator.validate(.city, city)
            } else {
                return true
            }
        }
        
        return validator.validate(.name, name)
            && validator.validate(.cpf, cpf)
            && validator.validate(.phoneNumber, phoneNumber)
            && validator.validate(.email, email)
            && isValidJuridicalPerson
            && isValidAddress
    }
}
