//
//  RemoteAuthorizationFactory.swift
//  Main
//
//  Created by Heitor Novais | Gerencianet on 23/06/21.
//

import Foundation
import Domain
import Data

func makeRemoteAuthorization() -> Authorization {
    return makeRemoteAuthorizationWith(endpoint: makeAuthorizationEndpoint(), httpClient: makeAlamofireAdapter())
}

func makeRemoteAuthorizationWith(endpoint: Endpoint, httpClient: HttpPostClient) -> Authorization {
    return RemoteAuthorization(endpoint: endpoint, httpClient: httpClient)
}
