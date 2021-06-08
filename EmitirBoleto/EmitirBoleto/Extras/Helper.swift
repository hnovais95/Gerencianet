//
//  Helper.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 21/05/21.
//

import Foundation

struct Helper {
    
    // MARK: - Conversions
    
    static func getPrice(_ value: Int) -> String {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: Constants.LocaleIdentifier.ptBR)
        return formatter.string(from: NSNumber(value: Double(value) / 100.0)) ?? formatter.string(from: 0)!
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
    
    
    // MARK: - Checks
    
    static func isNumber(textToValidate: String) -> Bool {
        let num = Int(textToValidate)
        
        if num != nil {
            return true
        }
        
        return false
    }
    
    static func hasSpecialCharacter(searchTerm: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z0-9].*", options: NSRegularExpression.Options())
        
        if regex.firstMatch(in: searchTerm, options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, searchTerm.count)) != nil {
            return true
        }
        
        return false
        
    }
    
    
    // MARK: - Handle strings
    
    static func removeMaskCharacters(text: String, withMask mask: String) -> String {
        var mask = mask
        var text = text
        mask = mask.replacingOccurrences(of: "X", with: "")
        mask = mask.replacingOccurrences(of: "N", with: "")
        mask = mask.replacingOccurrences(of: "C", with: "")
        mask = mask.replacingOccurrences(of: "c", with: "")
        mask = mask.replacingOccurrences(of: "U", with: "")
        mask = mask.replacingOccurrences(of: "u", with: "")
        mask = mask.replacingOccurrences(of: "*", with: "")
        
        var index = mask.startIndex
        
        while(index != mask.endIndex) {
            text = text.replacingOccurrences(of: "\(mask[index])", with: "")
            index = mask.index(after: index)
        }
        
        return text
    }
    
    
    static func applyMask(text: String, maskString: String) -> String {
        var text = Helper.removeMaskCharacters(text: text, withMask: maskString)
        var textWithMask = ""
        
        var index = maskString.startIndex
        var i = 0
        
        while(index != maskString.endIndex) {
            if (i >= text.count) {
                text = textWithMask
                break
            }
            
            if ("\(maskString[index])" == "N") { // Only number
                if (!Helper.isNumber(textToValidate: text[i])) {
                    break
                }
                textWithMask = textWithMask + text[i]
                i += 1
            } else if ("\(maskString[index])" == "C") { // Only Characters A-Z, Upper case only
                if (Helper.hasSpecialCharacter(searchTerm: text[i])) {
                    break
                }
                
                if (Helper.isNumber(textToValidate: text[i])) {
                    break
                }
                textWithMask = textWithMask + String(text[i]).uppercased()
                i += 1
            } else if ("\(maskString[index])" == "c") { // Only Characters a-z, lower case only
                if (Helper.hasSpecialCharacter(searchTerm: text[i])) {
                    break
                }
                
                if (Helper.isNumber(textToValidate: text[i])) {
                    break
                }
                textWithMask = textWithMask + String(text[i]).lowercased()
                i += 1
            } else if ("\(maskString[index])" == "X") { // Only Characters a-Z
                if (Helper.hasSpecialCharacter(searchTerm: text[i])) {
                    break
                }
                
                if (Helper.isNumber(textToValidate: text[i])) {
                    break
                }
                textWithMask = textWithMask + text[i]
                i += 1
            } else if ("\(maskString[index])" == "%") { // Characters a-Z + Numbers
                if (Helper.hasSpecialCharacter(searchTerm: text[i])) {
                    break
                }
                textWithMask = textWithMask + text[i]
                i += 1
            } else if ("\(maskString[index])" == "U") { // Only Characters A-Z + Numbers, Upper case only
                if (Helper.hasSpecialCharacter(searchTerm: text[i])) {
                    break
                }
                
                textWithMask = textWithMask + String(text[i]).uppercased()
                i += 1
            } else if ("\(maskString[index])" == "u") { // Only Characters a-z + Numbers, lower case only
                if (Helper.hasSpecialCharacter(searchTerm: text[i])) {
                    break
                }
                
                textWithMask = textWithMask + String(text[i]).lowercased()
                i += 1
            } else if ("\(maskString[index])" == "*") { // Any Character
                textWithMask = textWithMask + text[i]
                i += 1
            } else {
                textWithMask = textWithMask + "\(maskString[index])"
            }
            
            index = maskString.index(after: index)
        }
        
        return textWithMask
    }
}

