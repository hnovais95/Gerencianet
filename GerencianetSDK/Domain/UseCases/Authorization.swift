//
//  Authorization.swift
//  Domain
//
//  Created by Heitor Novais | Gerencianet on 23/06/21.
//

import Foundation

public protocol Authorization {
    
    typealias Result = Swift.Result<AuthorizationResponseModel, DomainError>
    func authorize(model: AuthorizationModel, completion: @escaping (Authorization.Result) -> Void)
}

public struct AuthorizationModel {
    
    public var clientId: String
    public var clientSecret: String
    
    public init(clientId: String, clientSecret: String) {
        self.clientId = clientId
        self.clientSecret = clientSecret
    }
}
