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
        authenticator.authorize(user: UserDto(user)) { response, error  in
            if error == nil {
                user.updateToken("\(response!.tokenType) \(response!.accessToken)")
                completion(.success(nil))
            } else {
                completion(.failure(error!))
            }
        }
    }
}
