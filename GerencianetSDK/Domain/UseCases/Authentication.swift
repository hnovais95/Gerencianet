//
//  Authentication.swift
//  Domain
//
//  Created by Heitor Novais | Gerencianet on 22/06/21.
//

import Foundation

public protocol Authentication {
    
    typealias Result = Swift.Result<AuthenticationResponseModel, DomainError>
    func auth(model: AuthenticationModel, completion: @escaping (Authentication.Result) -> Void)
}

public struct AuthenticationModel {
    
    public var login: String
    public var password: String
    
    public init(login: String, password: String) {
        self.login = login
        self.password = password
    }
}
