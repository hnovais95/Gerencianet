//
//  Authorization.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 13/05/21.
//

import Foundation

class HeadersFactory {
    static func makeGetAuthorizeHeaders(clientID: String, clientSecret: String) -> Data? {
        let headers = ["Authorization": "Basic" + " " + (#"\(clientID):\(clientSecret)"#).toBase64()]
        
        return try? JSONSerialization.data(withJSONObject: headers)
    }
    
    static func makeAuthorizationHeaders(accessToken: String) -> Data? {
        let headers = ["Authorization": accessToken,
                       "Content-Type": #"application/json"#]
        
        return try? JSONSerialization.data(withJSONObject: headers)
    }
}
