//
//  AuthenticationAPI.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

protocol Authenticator {
    func authorize(user: User,
                   completionHandler: @escaping (Result<AuthorizeResponse, NetworkError>) -> Void)
}
