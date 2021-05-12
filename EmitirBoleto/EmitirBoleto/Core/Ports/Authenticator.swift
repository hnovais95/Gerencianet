//
//  AuthenticationAPI.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

protocol Authenticator {
    func authorize(user: UserModel,
                   completionHandler: @escaping (Result<AuthorizeResponse, NetworkError>) -> Void)
}
