//
//  Gerencianet+Authentication.swift
//  Main
//
//  Created by Heitor Novais | Gerencianet on 22/06/21.
//

import Domain
import Data

extension Gerencianet {
    
    public func auth(model: AuthenticationModel, completion: @escaping (Result<Any?, DomainError>) -> Void) {
        let remoteAuthentication = makeRemoteAuthentication()
        let authenticationModel = AuthenticationModel(login: model.login, password: model.password)
        remoteAuthentication.auth(model: authenticationModel) { [weak self] result in
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
