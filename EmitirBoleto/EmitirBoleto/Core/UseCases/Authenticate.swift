//
//  Authenticate.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

class Authenticate {
    private let authenticator: Authenticator
    private let userRepository: UserRepository
    
    init(authenticator: Authenticator, userRepository: UserRepository) {
        self.authenticator = authenticator
        self.userRepository = userRepository
    }
    
    func authorize(user: UserModel) {
        var token: String?
        
        authenticator.authorize(user: user) { result in
            switch result {
            case .success(let response):
                token = response.accessToken
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        if let token = token {
            user.setToken(token)
            userRepository.save(UserData(user))
        }
    }
}
