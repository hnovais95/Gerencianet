//
//  ChangeOneStep.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

import Foundation

class Payment {
    private let paymentGateway: PaymentGateway
    
    init(paymentGateway: PaymentGateway) {
        self.paymentGateway = paymentGateway
    }
    
    func createCharge(customer: Person, data: ChargeData) -> ChargeOneStepResponse? {
        var paymentResponse: ChargeOneStepResponse?
        
        paymentGateway.createChargeOneStep(customer: customer, data: data) { result in
            switch result {
            case .success(let response):
                paymentResponse = response
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        return paymentResponse
    }
}
