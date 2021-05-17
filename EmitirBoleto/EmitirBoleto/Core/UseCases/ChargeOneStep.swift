//
//  ChangeOneStep.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

class ChargeOneStep {
    private let paymentGateway: PaymentGateway
    
    init(paymentGateway: PaymentGateway) {
        self.paymentGateway = paymentGateway
    }
    
    func execute(user: UserModel,
                 data: ChargeOneStepModel,
                 completion: @escaping (Result<ChargeOneStepResponse, APIError>) -> Void) {
        paymentGateway.createChargeOneStep(token: user.token, data: ChargeOneStepDto(data)) { result in
                
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
