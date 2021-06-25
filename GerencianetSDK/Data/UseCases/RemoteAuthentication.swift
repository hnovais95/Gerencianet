//
//  RemoteAuthentication.swift
//  Data
//
//  Created by Heitor Novais | Gerencianet on 22/06/21.
//

import Foundation
import Domain

public final class RemoteAuthentication: Authentication {
    
    private let endpoint: Endpoint
    private let httpClient: HttpPostClient
    
    public init(endpoint: Endpoint, httpClient: HttpPostClient) {
        self.endpoint = endpoint
        self.httpClient = httpClient
    }
    
    public func auth(model: AuthenticationModel, completion: @escaping (Authentication.Result) -> Void) {
        httpClient.post(to: endpoint.url, method: endpoint.method, withHeaders: makeAuthenticationHeaders(model: model), withBody: makeAuthenticationBody()) { [weak self] result in
            guard let _ = self else { return }
            switch result {
            case .success(let data):
                if let model: AuthenticationResponseModel = data?.toModel() {
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

public func makeAuthenticationHeaders(model: AuthenticationModel) -> [[String: String]] {
    let authorizationHeader = [
        "name": "Authorization",
        "value": "Basic" + " " + "\(model.login):\(model.password)".toBase64()
    ]
    
    return [authorizationHeader]
}

public func makeAuthenticationBody() -> [String: Any] {
    return ["grant_type": "client_credentials"]
}
