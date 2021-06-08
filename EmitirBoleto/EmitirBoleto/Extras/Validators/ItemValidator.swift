//
//  Validator.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 31/05/21.
//

struct ItemValidator: Validator {
    
    enum ItemValidityType: Int {
        case name, value, amount
    }
    
    func validate(_ rawValue: Int, _ value: String) -> Bool {
        guard let type = ItemValidityType(rawValue: rawValue) else { return false }        
        return validate(type, value)
    }
    
    func validate(_ type: ItemValidityType, _ value: String) -> Bool {
        switch type {
        case .name:
            return validadeLength(1...255, value)
                && validadeRegex("^[^<>]+$", value)
        case .value:
            return (Int(value) != nil) && (Int(value)! > 0)
        case .amount:
            return (Int(value) != nil) && (Int(value)! > 0)
        }
    }
}
