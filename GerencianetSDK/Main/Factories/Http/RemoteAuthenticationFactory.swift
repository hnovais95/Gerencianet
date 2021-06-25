//
//  RemoteAuthenticationFactory.swift
//  Main
//
//  Created by Heitor Novais | Gerencianet on 23/06/21.
//

import Foundation
import Domain
import Data

func makeRemoteAuthentication() -> Authentication {
    return makeRemoteAuthenticationWith(endpoint: makeAuthenticationEndpoint(), httpClient: makeAlamofireAdapter())
}

func makeRemoteAuthenticationWith(endpoint: Endpoint, httpClient: HttpClient) -> Authentication {
    return RemoteAuthentication(endpoint: endpoint, httpClient: httpClient)
}
