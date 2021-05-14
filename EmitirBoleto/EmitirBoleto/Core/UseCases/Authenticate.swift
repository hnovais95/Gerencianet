//
//  Authenticate.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

class Authenticate {
    private let authenticator: PaymentGateway
    //private let userRepository: UserRepository
    
    init(authenticator: PaymentGateway) {//, userRepository: UserRepository) {
        self.authenticator = authenticator
        //self.userRepository = userRepository
    }
    
    func authorize(user: UserModel, completion: @escaping (Result<Optional<Any>, Error>) -> Void) {
        authenticator.authorize(user: UserDto(user)) { result in
            switch result {
            case .success(let response):
                user.updateToken("\(response.tokenType) \(response.accessToken)")
                completion(.success(nil))
                break
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
