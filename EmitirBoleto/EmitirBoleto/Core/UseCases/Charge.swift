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
    
    func createChargeOneStep(user: UserModel, charge: ChargeOneStepModel) -> ChargeOneStepResponse? {
        guard let token = user.token else { return nil }
        
        var chargeResponse: ChargeOneStepResponse?
        
        paymentGateway.createChargeOneStep(token: token, data: ChargeOneStepDto(charge)) { result in
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
