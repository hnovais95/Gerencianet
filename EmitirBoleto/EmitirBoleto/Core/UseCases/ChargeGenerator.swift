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
    
    func createCharge(localCharge: ChargeModel) -> ChargeOneStepResponse? {
        var chargeResponse: ChargeOneStepResponse?
        
        paymentGateway.createChargeOneStep(data: ChargeData(localCharge)) { result in
            switch result {
            case .success(let response):
                chargeResponse = response
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        return chargeResponse
    }
}
