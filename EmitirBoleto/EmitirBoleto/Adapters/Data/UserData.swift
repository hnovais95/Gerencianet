//
//  UserData.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

struct UserData: Serializable {
    let clientID: String
    let clientSecret: String
    let token: String?
    let cache: [String:String]?
    
    init(_ user: UserModel) {
        self.clientID = user.clientID
        self.clientSecret = user.clientSecret
        self.token = user.token
        self.cache = user.cache
    }
    
    init(clientID: String, clientSecret: String) {
        self.clientID = clientID
        self.clientSecret = clientSecret
        self.token = nil
        self.cache = nil
    }
    
    init(clientID: String, clientSecret: String, token: String) {
        self.clientID = clientID
        self.clientSecret = clientSecret        
        self.token = token        
        self.cache = nil
    }
    
    init(clientID: String, clientSecret: String, token: String, context: [String:String]?) {
        self.clientID = clientID
        self.clientSecret = clientSecret
        self.token = token
        self.cache = context
    }
    
    static func == (lhs: UserData, rhs: UserData) -> Bool {
        return lhs.clientID == rhs.clientID && lhs.clientSecret == rhs.clientSecret
    }
}
