//
//  Gerencianet+Authentication.swift
//  Main
//
//  Created by Heitor Novais | Gerencianet on 23/06/21.
//

import Domain
import Data

extension Gerencianet {
    
    public func auth(model: AuthenticationModel, completion: @escaping (Result<Any?, GnError>) -> Void) {
        let remoteAuthentication = makeRemoteAuthentication()
        let authorizationModel = AuthenticationModel(clientId: model.clientId, clientSecret: model.clientSecret)
        remoteAuthentication.execute(model: authorizationModel) { [weak self] result in
            guard self != nil else { return }
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
