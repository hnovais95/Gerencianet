//
//  HeadersFactory.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 14/05/21.
//

import Alamofire
import Foundation

class HeadersFactory {
    static func makeAuthorizeHeaders(clientId: String, clientSecret: String) -> [[String: String]] {
        let authorizationHeader = [
            "name": "Authorization",
            "value": "Basic" + " " + "\(clientId):\(clientSecret)".toBase64()
        ]
        
        return [authorizationHeader]
    }
    
    static func makeChargeOneStepHeaders(accessToken: String) -> [[String: String]] {        
        let authorizationHeader = [
            "name": "Authorization",
            "value": accessToken
        ]
        
        let contentTypeHeader = [
            "name": "Content-Type",
            "value": "application/json"
        ]
        
        return [authorizationHeader, contentTypeHeader]
    }
}
