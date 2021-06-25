//
//  Authentication.swift
//  Domain
//
//  Created by Heitor Novais | Gerencianet on 23/06/21.
//

import Foundation

public protocol Authentication {
    
    typealias Result = Swift.Result<AuthenticationResponseModel, GnError>
    func execute(model: AuthenticationModel, completion: @escaping (Authentication.Result) -> Void)
}

public struct AuthenticationModel {
    
    public var clientId: String
    public var clientSecret: String
    
    public init(clientId: String, clientSecret: String) {
        self.clientId = clientId
        self.clientSecret = clientSecret
    }
}
