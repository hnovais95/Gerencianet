//
//  AuthenticationDataRequestFactory.swift
//  Data
//
//  Created by Heitor Novais | Gerencianet on 25/06/21.
//

import Domain

public func makeAuthorizationHeaders(model: AuthenticationModel) -> [[String: String]] {
    let authorizationHeader = [
        "name": "Authorization",
        "value": "Basic" + " " + "\(model.clientId):\(model.clientSecret)".toBase64()
    ]
    
    return [authorizationHeader]
}

public func makeAuthorizationBody() -> [String: Any] {
    return ["grant_type": "client_credentials"]
}
