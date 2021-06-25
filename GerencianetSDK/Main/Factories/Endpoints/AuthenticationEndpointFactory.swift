//
//  AuthenticationEndpointFactory.swift
//  Domain
//
//  Created by Heitor Novais | Gerencianet on 22/06/21.
//

import Domain

public func makeAuthenticationEndpoint() -> Endpoint {
    return Endpoint(url: makeApiUrl(path: "authorize"), method: "POST")
}

