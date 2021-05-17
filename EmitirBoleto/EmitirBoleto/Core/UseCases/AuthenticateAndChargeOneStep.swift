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
                 completion: @escaping (Result<ChargeOneStepResponse, APIError>) -> Void) {
        let authenticator = AuthenticationManager(paymentGateway: paymentGateway)
        let authenticatorGroup = DispatchGroup()
        
        authenticatorGroup.enter()
        authenticator.authenticate(user: UserModel.shared) { result in
            
            switch result {
            case .failure(let error):
                completion(.failure(error))
            default:
                break
            }
            
            authenticatorGroup.leave()
        }
        
        authenticatorGroup.notify(queue: DispatchQueue.main) {
            let chargeOneStep = ChargeOneStep(paymentGateway: self.paymentGateway)
            
            chargeOneStep.execute(user: UserModel.shared, data: data, completion: { result in
                
                switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
        }
    }
}

