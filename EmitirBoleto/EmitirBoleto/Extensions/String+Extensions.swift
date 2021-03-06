//
//  String+Extensions.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 13/05/21.
//

import Foundation

extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        
        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}

extension String {
    
    func isLastCharANumber() -> Bool {
        let lastChar = self.last!
        
        if lastChar.isNumber {
            return true
        } else {
            return false
        }
    }
}
