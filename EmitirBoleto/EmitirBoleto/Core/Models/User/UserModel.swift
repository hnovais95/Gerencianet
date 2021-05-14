//
//  User.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

import Foundation

class UserModel: Equatable {
    private(set) var clientId: String
    private(set) var clientSecret: String
    private(set) var token: String
    
    init(clientID: String, clientSecret: String)
    {
        self.clientId = clientID
        self.clientSecret = clientSecret
        self.token = ""
    }
    
    func updateToken(_ token: String) {
        self.token = token
    }
    
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.clientId == rhs.clientId
    }
}
