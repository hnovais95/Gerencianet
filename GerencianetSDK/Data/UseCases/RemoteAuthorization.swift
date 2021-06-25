//
//  RemoteAuthorization.swift
//  Data
//
//  Created by Heitor Novais | Gerencianet on 23/06/21.
//

import Foundation
import Domain

public final class RemoteAuthorization: Authorization {
    
    private let endpoint: Endpoint
    private let httpClient: HttpPostClient
    
    public init(endpoint: Endpoint, httpClient: HttpPostClient) {
        self.endpoint = endpoint
        self.httpClient = httpClient
    }
    
    public func authorize(model: AuthorizationModel, completion: @escaping (Authorization.Result) -> Void) {
        httpClient.post(to: endpoint.url, method: endpoint.method, withHeaders: makeAuthorizationHeaders(model: model), withBody: makeAuthorizationBody()) { result in
            switch result {
            case .success(let data):
                if let model: AuthorizationResponseModel = data?.toModel() {
                    completion(.success(model))
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure(let error):
                switch error {
                case .unauthorized:
                    completion(.failure(.expiredSession))
                default:
                    completion(.failure(.unexpected))
                }
            }
        }
    }
}

public func makeAuthorizationHeaders(model: AuthorizationModel) -> [[String: String]] {
    let authorizationHeader = [
        "name": "Authorization",
        "value": "Basic" + " " + "\(model.clientId):\(model.clientSecret)".toBase64()
    ]
    
    return [authorizationHeader]
}

public func makeAuthorizationBody() -> [String: Any] {
    return ["grant_type": "client_credentials"]
}
