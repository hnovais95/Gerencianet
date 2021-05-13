//
//  Authenticate.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

class Authenticate {
    private let authenticator: PaymentGateway
    private let userRepository: UserRepository
    
    init(authenticator: PaymentGateway, userRepository: UserRepository) {
        self.authenticator = authenticator
        self.userRepository = userRepository
    }
    
    func authorize(user: UserModel) {
        authenticator.authorize(user: user) { result in
            switch result {
            case .success(let response):
                let token = "\(response.tokenType) \(response.accessToken)"
                self.userRepository.saveToken(user.token!)
                user.setToken(token)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
