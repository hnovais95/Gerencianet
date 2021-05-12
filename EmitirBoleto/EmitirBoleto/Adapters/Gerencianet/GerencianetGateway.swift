//
//  GerencianetGateway.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 12/05/21.
//

import Foundation

final class GerencianetGateway: PaymentGateway {
    private var url: URL
    private var httpClient: HTTPPostClient
    
    public init(url: URL, httpClient: HTTPPostClient) {
        self.url =  url
        self.httpClient = httpClient
    }
    
    public func createChargeOneStep(data chargeData: ChargeData,
                                    completion: @escaping (Result<ChargeOneStepResponse, DomainError>) -> Void) {
        let body = BodyFactory.makeCreateChargeOneStepBody(data: chargeData)
        
        httpClient.post(to: url, with: body) { result in            
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
