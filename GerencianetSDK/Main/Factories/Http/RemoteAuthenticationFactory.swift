//
//  RemoteAuthenticationFactory.swift
//  Main
//
//  Created by Heitor Novais | Gerencianet on 22/06/21.
//

import Foundation
import Domain
import Data

func makeRemoteAuthentication() -> Authentication {
    return makeRemoteAuthenticationWith(endpoint: makeChargeOneStepEndpoint(), httpClient: makeAlamofireAdapter())
}

func makeRemoteAuthenticationWith(endpoint: Endpoint, httpClient: HttpPostClient) -> Authentication {
    return RemoteAuthentication(endpoint: endpoint, httpClient: httpClient)
}
