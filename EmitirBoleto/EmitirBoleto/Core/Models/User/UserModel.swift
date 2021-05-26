//
//  UserModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

import Foundation

class UserModel {
    
    private(set) var clientId: String
    private(set) var clientSecret: String
    private let concurrentTokenQueue = DispatchQueue(label: "concurrentToken", attributes: .concurrent)
    private var unsafeToken: String
    
    var token: String {
        var tokenCopy: String!
        
        concurrentTokenQueue.sync {
            tokenCopy = self.unsafeToken
        }
        
        return tokenCopy
    }
    
    static var shared: UserModel = {
        let instance = UserModel()
        return instance
    }()
    
    private init()
    {
        self.clientId = Constants.Authentication.clientId
        self.clientSecret = Constants.Authentication.clientSecret
        self.unsafeToken = ""
    }
    
    func setToken(_ token: String) {
        concurrentTokenQueue.async(flags: .barrier) { [weak self] in
            guard let self = self else {
                return
            }
            
            self.unsafeToken = token
        }
    }
}

extension UserModel: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
