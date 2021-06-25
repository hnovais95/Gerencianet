//
//  AuthorizationEndpointFactory.swift
//  Main
//
//  Created by Heitor Novais | Gerencianet on 23/06/21.
//

import Domain

public func makeAuthorizationEndpoint() -> Endpoint {
    return Endpoint(url: makeApiUrl(path: "authorize"), method: "POST")
}
