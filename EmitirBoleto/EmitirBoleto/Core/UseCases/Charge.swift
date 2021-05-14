//
//  ChangeOneStep.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

class Charge {
    private let paymentGateway: PaymentGateway
    
    init(paymentGateway: PaymentGateway) {
        self.paymentGateway = paymentGateway
    }
    
    func createChargeOneStep(user: UserModel, charge: ChargeOneStepModel, completion: @escaping (Result<ChargeOneStepResponse, APIError>) -> Void) {
        paymentGateway.createChargeOneStep(token: user.token, data: ChargeOneStepDto(charge)) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
                break
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
