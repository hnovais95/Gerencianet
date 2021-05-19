//
//  AuthenticateAndChargeOneStep.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 17/05/21.
//

import Foundation

class AuthenticateAndChargeOneStep {
    
    private let paymentGateway: PaymentGateway

    init(paymentGateway: PaymentGateway) {
        self.paymentGateway = paymentGateway
    }
    
    func execute(user: UserModel,
                 data: ChargeOneStepModel,
                 completion: @escaping (Result<ChargeOneStepResponseModel, APIError>) -> Void) {        
        let authenticate = Authenticate(paymentGateway: paymentGateway)
        let authenticateGroup = DispatchGroup()
        authenticateGroup.enter()
        authenticate.execute(user: UserModel.shared) { _ in
            authenticateGroup.leave()
        }
        
        authenticateGroup.notify(queue: DispatchQueue.main) {
            let chargeOneStep = ChargeOneStep(paymentGateway: self.paymentGateway)
            chargeOneStep.execute(user: UserModel.shared, data: data, completion: { result in
                switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):                    
                    print("Erro ao autenticar e reprocessar emissão de boleto: \(error.localizedDescription).")
                    completion(.failure(error))
                }
            })
        }
    }
}

