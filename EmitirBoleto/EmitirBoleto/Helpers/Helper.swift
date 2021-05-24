//
//  Helper.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 21/05/21.
//

import Foundation

struct Helper {
    
    static func getInitialsName(_ name: String) -> String {
        var initials = ""
        
        let splitName = name.split(separator: " ")        
        if splitName.count > 0 {
            
            if let firstName = splitName.first, let lastName = splitName.last {
                initials.append(firstName.prefix(1).description)
                if firstName != lastName {
                    initials.append(lastName.prefix(1).description)
                }
            }
        }
        
        return initials
    }
    
    static func getPrice(_ value: Int) -> String {
        return String(format: "R$ %.2f", Double(value) / 100.0).replacingOccurrences(of: ".", with: ",")
    }
}
