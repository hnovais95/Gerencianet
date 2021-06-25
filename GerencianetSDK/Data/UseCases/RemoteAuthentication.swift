//
//  RemoteAuthentication.swift
//  Data
//
//  Created by Heitor Novais | Gerencianet on 23/06/21.
//

import Foundation
import Domain

public final class RemoteAuthentication: Authentication {
    
    private let endpoint: Endpoint
    private let httpClient: HttpClient
    
    public init(endpoint: Endpoint, httpClient: HttpClient) {
        self.endpoint = endpoint
        self.httpClient = httpClient
    }
    
    public func execute(model: AuthenticationModel, completion: @escaping (Authentication.Result) -> Void) {
        httpClient.request(to: endpoint.url, method: endpoint.method, withHeaders: makeAuthorizationHeaders(model: model), withBody: makeAuthorizationBody()) { result in
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
