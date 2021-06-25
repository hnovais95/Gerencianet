//
//  RemoteChargeOneStep.swift
//  Data
//
//  Created by Heitor Novais | Gerencianet on 22/06/21.
//

import Foundation
import Domain

public final class RemoteChargeOneStep: ChargeOneStep {
    
    private let endpoint: Endpoint
    private let httpClient: HttpClient
    
    public init(endpoint: Endpoint, httpClient: HttpClient) {
        self.endpoint = endpoint
        self.httpClient = httpClient
    }
    
    public func execute(token: String, model: ChargeOneStepModel, completion: @escaping (ChargeOneStep.Result) -> Void) {
        httpClient.request(to: endpoint.url, method: endpoint.method, withHeaders: makeChargeOneStepHeaders(token: token), withBody: makeChargeOneStepBody(model: model)) { result in
            switch result {
            case .success(let data):
                if let model: ChargeOneStepResponseModel = data?.toModel() {
                    completion(.success(model))
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure:
                completion(.failure(.unexpected))
            }
        }
    }
}
