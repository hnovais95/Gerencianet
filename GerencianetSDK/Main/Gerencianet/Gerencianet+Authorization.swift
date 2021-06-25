//
//  Gerencianet+Authorization.swift
//  Main
//
//  Created by Heitor Novais | Gerencianet on 23/06/21.
//

import Domain
import Data

extension Gerencianet {
    
    public func authorize(model: AuthorizationModel, completion: @escaping (Result<Any?, DomainError>) -> Void) {
        let remoteAuthorization = makeRemoteAuthorization()
        let authorizationModel = AuthorizationModel(clientId: model.clientId, clientSecret: model.clientSecret)
        remoteAuthorization.authorize(model: authorizationModel) { [weak self] result in
            switch result {
            case .success(let response):
                self?.saveToken(tokenType: response.tokenType, accessToken: response.accessToken)
                completion(.success(nil))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
