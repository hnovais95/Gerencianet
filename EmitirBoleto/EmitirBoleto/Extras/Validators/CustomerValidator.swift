//
//  CustomerValidator.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 31/05/21.
//

import CPF_CNPJ_Validator

struct CustomerValidator: Validator {
    
    enum CustomerValidityType: Int{
        case name, cpf, corporateName, cnpj, phoneNumber, email, street,
             number, complement, neighborhood, zipcode, state, city
    }    
    
    func validate(_ rawValue: Int, _ value: String) -> Bool {
        guard let type = CustomerValidityType(rawValue: rawValue) else { return false }
        
        return validate(type, value)
    }
    
    func validate(_ type: CustomerValidityType, _ value: String) -> Bool {
        switch type {
        case .name:
            return validadeLength(1...255, value)
                && validadeRegex("^[ ]*(.+[ ]+)+.+[ ]*$", value)
        case .cpf:
            return BooleanValidator().validate(cpf: value)
        case .corporateName:
            return validadeLength(1...255, value)
        case .cnpj:
            return BooleanValidator().validate(cnpj: value)
        case .phoneNumber:
            return validadeLength(11...11, value)
                && validadeRegex("^[1-9]{2}9?[0-9]{8}$", value)
        case .email:
            return validadeLength(1...320, value)
                && validadeRegex("^[A-Za-z0-9_\\-]+(?:[.][A-Za-z0-9_\\-]+)*@[A-Za-z0-9_]+(?:[-.][A-Za-z0-9_]+)*\\.[A-Za-z0-9_]+$", value)
        case .street:
            return validadeLength(0...200, value)
        case .number:
            return Int(value) != nil
        case .complement:
            return validadeLength(0...100, value)
        case .neighborhood:
            return validadeLength(1...255, value)
        case .zipcode:
            return validadeLength(8...8, value)
                && validadeRegex("^[0-9]{8}$", value)
        case .state:
            return validadeRegex("^(?:A[CLPM]|BA|CE|DF|ES|GO|M[ATSG]|P[RBAEI]|R[JNSOR]|S[CEP]|TO)$", value)
        case .city:
            return validadeLength(0...50, value)
        }
    }
}
