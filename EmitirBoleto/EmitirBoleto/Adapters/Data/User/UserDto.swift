//
//  UserData.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

struct UserDto: Serializable {
    let clientId: String
    let clientSecret: String
    let token: String
    
    init(_ user: UserModel) {
        self.init(user.clientId, user.clientSecret, user.token)
    }
    
    init(_ clientId: String, _ clientSecret: String, _ token: String) {
        self.clientId = clientId
        self.clientSecret = clientSecret        
        self.token = token
    }
    
    static func == (lhs: UserDto, rhs: UserDto) -> Bool {
        return lhs.clientId == rhs.clientId
    }
}
