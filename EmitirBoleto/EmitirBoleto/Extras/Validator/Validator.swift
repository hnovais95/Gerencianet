//
//  Validator.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 26/05/21.
//

import Foundation
import CPF_CNPJ_Validator

struct Validator {
    
    // MARK: Validates
    
    static func isValid(_ validityType: ValidityType, value: String) -> Bool {
        
        if (validityType.min == 0) && (value == "") {
            return true
        }
        
        if (validityType is CustomerValidityType) {
            if (validityType as! CustomerValidityType) == .cpf {
                return validadeCpf(value)
            }
            
            if (validityType as! CustomerValidityType) == .cnpj {
                return validadeCnpj(value)
            }
        }
        
        return validadeLength(validityType, value) && validadeRegex(validityType, value)
    }
    
    
    // MARK: Specialized validations
    
    private static func validadeLength(_ validityType: ValidityType, _ value: String) -> Bool {
        return validityType.min...validityType.max ~= value.count
    }
    
    private static func validadeRegex(_ validityType: ValidityType, _ value: String) -> Bool {
        let format = "SELF MATCHES %@"
        let regex = validityType.regex
        return NSPredicate(format: format, regex).evaluate(with: value)
    }
    
    private static func validadeCpf(_ value: String) -> Bool {
        return BooleanValidator().validate(cpf: value)
    }
    
    private static func validadeCnpj(_ value: String) -> Bool {
        return BooleanValidator().validate(cnpj: value)
    }
}
