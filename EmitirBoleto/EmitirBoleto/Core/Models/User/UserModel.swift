//
//  User.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

import Foundation

class UserModel: Equatable {
    private(set) var clientID: String
    private(set) var clientSecret: String
    private(set) var token: String?
    
    init(clientID: String, clientSecret: String)
    {
        self.clientID = clientID
        self.clientSecret = clientSecret
    }
    
    func setToken(_ token: String) {
        self.token = token
    }
    
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.clientID == rhs.clientID
    }
}
