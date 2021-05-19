//
//  Authenticate.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 18/05/21.
//

class Authenticate {
    private let paymentGateway: PaymentGateway
    
    init(paymentGateway: PaymentGateway) {
        self.paymentGateway = paymentGateway
    }
    
    func execute(user: UserModel,
                 completion: @escaping (Result<AuthorizeResponse, APIError>) -> Void) {
        paymentGateway.authorize(user: UserDto(user)) { result in            
            switch result {
            case .success(let response):
                user.setToken("\(response.tokenType) \(response.accessToken)")
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
