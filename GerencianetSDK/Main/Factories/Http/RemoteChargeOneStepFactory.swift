//
//  RemoteChargeOneStepFactory.swift
//  Main
//
//  Created by Heitor Novais | Gerencianet on 22/06/21.
//

import Foundation
import Domain
import Data

func makeRemoteChargeOneStep() -> ChargeOneStep {
    return makeRemoteChargeOneStepWith(endpoint: makeChargeOneStepEndpoint(), httpClient: makeAlamofireAdapter())
}

func makeRemoteChargeOneStepWith(endpoint: Endpoint, httpClient: HttpClient) -> ChargeOneStep {
    return RemoteChargeOneStep(endpoint: endpoint, httpClient: httpClient)
}
