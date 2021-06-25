//
//  ChangeOneStepEndpointFactory.swift
//  Domain
//
//  Created by Heitor Novais | Gerencianet on 22/06/21.
//

import Domain

public func makeChargeOneStepEndpoint() -> Endpoint {
    return Endpoint(url: makeApiUrl(path: "charge/one-step"), method: "POST")
}

