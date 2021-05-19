//
//  ChangeOneStep.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

class ChargeOneStep {
    
    private let paymentGateway: PaymentGateway
    
    init(paymentGateway: PaymentGateway) {
        self.paymentGateway = paymentGateway
    }
    
    func execute(user: UserModel,
                 data: ChargeOneStepModel,
                 completion: @escaping (Result<ChargeOneStepResponseModel, APIError>) -> Void) {
        paymentGateway.createChargeOneStep(token: user.token, data: data) { result in                
            switch result {
            case .success(let response):
                print("Boleto emitido com sucesso. ChargeId:\(response.data.chargeId).")
                completion(.success(response))
            case .failure(let error):
                print("Erro ao emitir boleto: \(error.localizedDescription).")
                completion(.failure(error))
            }
        }
    }
}
