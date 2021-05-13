//
//  UserData.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

struct UserDto: Serializable {
    let clientID: String
    let clientSecret: String
    let token: String?
    
    init(_ user: UserModel) {
        self.clientID = user.clientID
        self.clientSecret = user.clientSecret
        self.token = user.token
    }
    
    init(clientID: String, clientSecret: String) {
        self.clientID = clientID
        self.clientSecret = clientSecret
        self.token = nil
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
    }
    
    static func == (lhs: UserDto, rhs: UserDto) -> Bool {
        return lhs.clientID == rhs.clientID
    }
}
