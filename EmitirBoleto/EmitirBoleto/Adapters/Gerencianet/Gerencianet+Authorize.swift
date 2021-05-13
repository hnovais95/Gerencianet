//
//  Gerencianet+Authorize.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 13/05/21.
//

import Foundation

extension Gerencianet {
    func authorize(user: UserModel,
                   completion: @escaping (Result<AuthorizeResponse, DomainError>) -> Void) {
        
        guard let headers = HeadersFactory.makeGetAuthorizeHeaders(clientID: user.clientID,
                                                       clientSecret: user.clientSecret) else {
            return completion(.failure(.unexpected))
        }
        guard let body = BodyFactory.makeGetAuthorizeBody() else {
            return completion(.failure(.unexpected))
        }
        guard let url = URL(string: Endpoints.authorize) else {
            return completion(.failure(.unexpected))
        }
        
        httpClient.post(to: url, with: body, headers: headers) { result in
            switch result {
            case .success(let data):
                if let response: AuthorizeResponse = data?.toModel() {
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
