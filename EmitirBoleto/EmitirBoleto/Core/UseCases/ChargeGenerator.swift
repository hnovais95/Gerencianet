//
//  ChangeOneStep.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

class ChargeGenerator {
    private let paymentGateway: PaymentGateway
    
    init(paymentGateway: PaymentGateway) {
        self.paymentGateway = paymentGateway
    }
    
    func createCharge(customer: Person, data: ChargeData) -> ChargeOneStepResponse? {
        var chargeResponse: ChargeOneStepResponse?
        
        func completionHandle(result: Result<ChargeOneStepResponse, NetworkError>) {
            switch result {
            case .success(let response):
                chargeResponse = response
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        if customer is JuridicalPersonModel {
            let customer = customer as! JuridicalPersonModel
            paymentGateway.createChargeOneStep(customer: JuridicalPersonData(customer), data: data) {
                completionHandle(result: $0)
            }
            
        } else {
            let customer = customer as! NaturalPersonModel
            paymentGateway.createChargeOneStep(customer: NaturalPersonData(customer), data: data) {
                completionHandle(result: $0)
            }
        }
        
        return chargeResponse
    }
}
