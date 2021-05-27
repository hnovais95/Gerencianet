//
//  InsertCustomerViewModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 26/05/21.
//

import Foundation

class InsertCustomerViewModel {
    
    private let validator = Validator()
    
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
    
    func validadeField(_ rawValueFieldType: Int, value: String) {
        guard let type = Validator.ValidityType(rawValue: rawValueFieldType) else { return }
        
        let result = validator.isValid(type, value: value)
        validatedField(result, rawValueFieldType)
    }
    
    func getCustomer() -> CustomerModel {
        var juridicalPerson: JuridicalPersonModel?
        if isJuridicalPerson {
            juridicalPerson = JuridicalPersonModel(corporateName, cnpj)
        }
        
        var address: AddressModel?
        if includeAddress {
            address = AddressModel(street, Int(number)!, neighborhood, zipcode, city, complement, state)
        }
        
        return CustomerModel(name, cpf, phoneNumber, "2000-01-01", email, address, juridicalPerson)
    }
}

extension InsertCustomerViewModel {
    
    var isValid: Bool {
        var isValidJuridicalPerson: Bool {
            if isJuridicalPerson {
                return validator.isValid(.cnpj, value: cnpj)
                    && validator.isValid(.corporateName, value: corporateName)
            } else {
                return true
            }
        }
        
        var isValidJuridicalAddress: Bool {
            if includeAddress {
                return validator.isValid(.street, value: street)
                    && validator.isValid(.number, value: number)
                    && validator.isValid(.complement, value: complement)
                    && validator.isValid(.neighborhood, value: neighborhood)
                    && validator.isValid(.zipcode, value: zipcode)
                    && validator.isValid(.state, value: state)
                    && validator.isValid(.city, value: city)
            } else {
                return true
            }
        }
        
        return validator.isValid(.name, value: name)
            && validator.isValid(.cpf, value: cpf)
            && validator.isValid(.phoneNumber, value: phoneNumber)
            && validator.isValid(.email, value: email)
            && isValidJuridicalPerson
            && isValidJuridicalAddress
    }
}
