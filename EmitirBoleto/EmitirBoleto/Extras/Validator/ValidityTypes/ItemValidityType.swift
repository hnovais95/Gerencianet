//
//  ItemValidityType.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 28/05/21.
//

enum ItemValidityType: Int, ValidityType {
    case name
    case value
    case amount
    
    var min: Int {
        switch self {
        case .amount: return 0
        default: return 1
        }
    }
        
    var max: Int {
        switch self {
        case .value, .amount: return 8
        default: return 255
        }
    }
    
    var regex: String {
        switch self {
        case .name: return "^[^<>]+$"
        case .value: return "^[0-9]+$"
        case .amount: return "^[0-9]*$"
        }
    }
}
