//
//  ViewModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 17/05/21.
//

import Foundation

class ChargeViewModel {
    private let gerencianetClient = Gerencianet(httpClient: AlamofireClient())
    
    func chargeOneStep(data: ChargeOneStepModel) {
        let chargeOneStep = ChargeOneStep(paymentGateway: gerencianetClient)
        
        chargeOneStep.execute(user: UserModel.shared, data: data) { [weak self] result in
            
            switch result {
            case .success(let response):
                print("Boleto emitido com sucesso. ChargeId:\(response.data.chargeId)")
            case .failure(let error):
                if error == .unauthorized {
                    print("Unauthorize.")
                    self?.authenticateAndChargeOneStep(data: data)
                }
            }
        }
    }
    
    private func authenticateAndChargeOneStep(data: ChargeOneStepModel) {
        let authenticateAndChargeOneStep = AuthenticateAndChargeOneStep(paymentGateway: gerencianetClient)
        
        authenticateAndChargeOneStep.execute(user: UserModel.shared, data: data) { result in
            
            switch result {
            case .success(let response):
                print("Boleto emitido com sucesso. ChargeId:\(response.data.chargeId)")
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
}