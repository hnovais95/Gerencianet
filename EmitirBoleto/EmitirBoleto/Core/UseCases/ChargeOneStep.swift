//
//  ChangeOneStep.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

import Foundation

class ChargeOneStep {
    
    private let notificationCenter = NotificationCenter.default
    private let paymentGateway: PaymentGateway
    
    init(paymentGateway: PaymentGateway) {
        self.paymentGateway = paymentGateway
    }
    
    func execute(user: UserModel, data: ChargeOneStepModel) {
        paymentGateway.createChargeOneStep(token: user.token, data: data) { result in
            switch result {
            case .success(let response):
                self.notificationCenter.post(name: .chargeSuccess, object: response)
                
            case .failure(let error):
                self.notificationCenter.post(name: .chargeFailure, object: error)
            }
        }
    }
}
