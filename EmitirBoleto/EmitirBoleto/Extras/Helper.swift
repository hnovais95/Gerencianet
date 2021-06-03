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
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: NSNumber(value: value / 100)) ?? formatter.string(from: 0)!
    }
    
    // dd/MM/yyyy -> yyyy-MM-dd
    static func convertDateToReverseFormat(_ date: String) -> String? {
        let array = date.split(separator: #"/"#)
        if array.count == 3 {
            let year = array[2]
            let month = array[1]
            let day = array[0]
            return "\(year)-\(month)-\(day)"
        } else {
            return nil
        }
    }
    
    // yyyy-MM-dd -> dd/MM/yyyy
    static func convertDateToNormalFormat(_ date: String) -> String? {        
        let array = date.split(separator: "-")
        if array.count == 3 {
            let year = array[0]
            let month = array[1]
            let day = array[2]
            return "\(day)/\(month)/\(year)"
        } else {
            return nil
        }
    }
}
