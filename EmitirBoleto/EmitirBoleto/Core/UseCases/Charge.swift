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
    
    func createChargeOneStep(user: UserModel, charge: ChargeOneStepModel, completion: @escaping (Result<ChargeOneStepResponse, Error>) -> Void) {
        paymentGateway.createChargeOneStep(token: user.token, chargeData: ChargeOneStepDto(charge)) { response, error in
            if error == nil {
                completion(.success(response!))
            } else {
                completion(.failure(error!))
            }
        }
    }
}
