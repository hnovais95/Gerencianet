//
//  CustomerValidityType.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 28/05/21.
//

enum CustomerValidityType: Int, ValidityType {    
    case name
    case cpf
    case corporateName
    case cnpj
    case phoneNumber
    case email
    case street
    case number
    case complement
    case neighborhood
    case zipcode
    case state
    case city
    
    var min: Int {
        switch self {
        case .name: return 1
        case .cpf: return 11
        case .corporateName: return 1
        case .cnpj: return 14
        case .phoneNumber: return 10
        case .neighborhood: return 1
        case .zipcode: return 8
        case .state: return 2
        default: return 0
        }
    }
        
    var max: Int {
        switch self {
        case .cpf: return 11
        case .cnpj: return 14
        case .phoneNumber: return 11
        case .street: return 200
        case .number: return 55
        case .complement: return 100
        case .zipcode: return 8
        case .state: return 2
        case .city: return 50
        default: return 255
        }
    }
    
    var regex: String {
        switch self {
        case .name: return "^[ ]*(.+[ ]+)+.+[ ]*$"
        case .cpf: return "^[0-9}{11}$"
        case .cnpj: return "^[0-9}{14}$"
        case .phoneNumber: return "^[1-9]{2}9?[0-9]{8}$"
        case .email: return "^[A-Za-z0-9_\\-]+(?:[.][A-Za-z0-9_\\-]+)*@[A-Za-z0-9_]+(?:[-.][A-Za-z0-9_]+)*\\.[A-Za-z0-9_]+$"
        case .zipcode: return "^[0-9]{8}$"
        case .state: return "^(?:A[CLPM]|BA|CE|DF|ES|GO|M[ATSG]|P[RBAEI]|R[JNSOR]|S[CEP]|TO)$"
        default: return ".*"
        }
    }
}
