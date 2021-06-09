//
//  Validator.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 31/05/21.
//

import Foundation

protocol Validator {
    
    func validate(_ rawValue: Int, _ value: String) -> Bool
}

extension Validator {
    
    func validadeLength(_ validRange: ClosedRange<Int>, _ value: String) -> Bool {
        return validRange ~= value.count
    }
    
    func validadeRegex(_ regex: String, _ value: String) -> Bool {
        let format = "SELF MATCHES %@"
        return NSPredicate(format: format, regex).evaluate(with: value)
    }
}
