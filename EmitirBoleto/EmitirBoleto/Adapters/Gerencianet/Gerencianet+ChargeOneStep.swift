//
//  Gerencianet+Pay.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 13/05/21.
//

import Foundation

extension Gerencianet {
    func createChargeOneStep(token: String,
                                    data chargeData: ChargeOneStepDto,
                                    completion: @escaping (Result<ChargeOneStepResponse, DomainError>) -> Void) {
        
        guard let headers = HeadersFactory.makeAuthorizationHeaders(accessToken: token) else {
            return completion(.failure(.unexpected))
        }
        guard let body = BodyFactory.makeChargeOneStepBody(parameters: chargeData) else {
            return completion(.failure(.unexpected))
        }
        guard let url = URL(string: Endpoints.chargeOneStep) else {
            return completion(.failure(.unexpected))
        }
        
        httpClient.post(to: url, with: body, headers: headers) { result in
            switch result {
            case .success(let data):
                if let response: ChargeOneStepResponse = data?.toModel() {
                    completion(.success(response))
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure:
                completion(.failure(.unexpected))
            }
        }
    }
}
