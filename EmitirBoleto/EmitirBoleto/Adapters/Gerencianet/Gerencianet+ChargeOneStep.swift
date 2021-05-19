//
//  Gerencianet+ChargeOneStep.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 14/05/21.
//

import Foundation

extension Gerencianet {
    func createChargeOneStep(token: String,
                             data: ChargeOneStepModel,
                             completion: @escaping (Result<ChargeOneStepResponseModel, APIError>) -> Void) {
        
        let route = GerencianetEndpoint.chargeOneStep(token: token, chargeData: data)
        
        httpClient.request(to: route.url, method: route.method, with: route.body, headers: route.headers) { result in
            switch result {
            case .success(let data):
                if let response: ChargeOneStepResponseModel = data?.toModel() {
                    completion(.success(response))
                } else {
                    completion(.failure(.responseBuilder))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
