//
//  UserData.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

struct UserData {
    private(set) var clientID: String
    private(set) var clientSecret: String
    private(set) var token: String?
    private(set) var context: [String:String]?
    
    init(_ user: User) {
        self.clientID = user.clientID
        self.clientSecret = user.clientSecret
        self.token = user.token
        self.context = user.context
    }
    
    init(clientID: String, clientSecret: String) {
        self.clientID = clientID
        self.clientSecret = clientSecret
    }
    
    init(clientID: String, clientSecret: String, token: String) {
        self.clientID = clientID
        self.clientSecret = clientSecret        
        self.token = token
    }
    
    init(clientID: String, clientSecret: String, token: String, context: [String:String]?) {
        self.clientID = clientID
        self.clientSecret = clientSecret
        self.token = token
        self.context = context
    }
}
