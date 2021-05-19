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
                 completion: @escaping (Result<AuthorizeResponseModel, APIError>) -> Void) {
        
        paymentGateway.authorize(clientId: user.clientId, clientSecret: user.clientSecret) { result in            
            switch result {
            case .success(let response):
                print("Autenticado.")
                user.setToken("\(response.tokenType) \(response.accessToken)")
                completion(.success(response))
            case .failure(let error):
                print("Erro ao autenticar: \(error.localizedDescription).")
                completion(.failure(error))
            }
        }
    }
}
