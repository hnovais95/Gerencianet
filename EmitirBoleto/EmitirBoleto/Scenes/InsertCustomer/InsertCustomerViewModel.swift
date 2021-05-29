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
        guard let type = CustomerValidityType(rawValue: rawValueFieldType) else { return }
        
        let result = Validator.isValid(type, value: value)
        validatedField(result, rawValueFieldType)
    }
    
    func getCustomer() -> CustomerModel {
        var juridicalPerson: JuridicalPersonModel?
        if isJuridicalPerson {
            juridicalPerson = JuridicalPersonModel(corporateName, cnpj)
        }
        
        var address: AddressModel?
        if includeAddress {
            let complement: String? = self.complement != "" ? self.complement : nil // complement is optional
            address = AddressModel(street, Int(number)!, neighborhood, zipcode, city, complement, state)
        }
        
        let email: String? = self.email != "" ? self.email : nil // email is optional
        return CustomerModel(name, cpf, phoneNumber, email, address, juridicalPerson)
    }
}

extension InsertCustomerViewModel {
    
    var isValid: Bool {
        var isValidJuridicalPerson: Bool {
            if isJuridicalPerson {
                return Validator.isValid(CustomerValidityType.cnpj, value: cnpj)
                    && Validator.isValid(CustomerValidityType.corporateName, value: corporateName)
            } else {
                return true
            }
        }
        
        var isValidJuridicalAddress: Bool {
            if includeAddress {
                return Validator.isValid(CustomerValidityType.street, value: street)
                    && Validator.isValid(CustomerValidityType.number, value: number)
                    && Validator.isValid(CustomerValidityType.complement, value: complement)
                    && Validator.isValid(CustomerValidityType.neighborhood, value: neighborhood)
                    && Validator.isValid(CustomerValidityType.zipcode, value: zipcode)
                    && Validator.isValid(CustomerValidityType.state, value: state)
                    && Validator.isValid(CustomerValidityType.city, value: city)
            } else {
                return true
            }
        }
        
        return Validator.isValid(CustomerValidityType.name, value: name)
            && Validator.isValid(CustomerValidityType.cpf, value: cpf)
            && Validator.isValid(CustomerValidityType.phoneNumber, value: phoneNumber)
            && Validator.isValid(CustomerValidityType.email, value: email)
            && isValidJuridicalPerson
            && isValidJuridicalAddress
    }
}
