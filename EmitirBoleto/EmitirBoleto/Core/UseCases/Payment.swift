//
//  ChangeOneStep.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

class Payment {
    private let paymentGateway: PaymentGateway
    
    init(paymentGateway: PaymentGateway) {
        self.paymentGateway = paymentGateway
    }
    
    func createCharge(customer: Person, data: ChargeData) -> ChargeOneStepResponse? {
        var paymentResponse: ChargeOneStepResponse?
        
        func completionHandle(result: Result<ChargeOneStepResponse, NetworkError>) {
            switch result {
            case .success(let response):
                paymentResponse = response
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        if customer is JuridicalPerson {
            paymentGateway.createChargeOneStep(customer: customer as! JuridicalPerson, data: data) {
                completionHandle(result: $0)
            }
            
        } else {
            paymentGateway.createChargeOneStep(customer: customer as! NaturalPerson, data: data) {
                completionHandle(result: $0)
            }
        }
        
        return paymentResponse
    }
}
