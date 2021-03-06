//
//  ViewModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 17/05/21.
//

import Foundation

class ChargeViewModel {
    
    private let gerencianetClient: PaymentGateway = Gerencianet(httpClient: AlamofireClient())
    private let costumerRepository: CustomerRepository = CoreDataCustomerRepository()
    private let itemRepository: ItemRepository = CoreDataItemRepository()
    
    func chargeOneStep(data: ChargeOneStepModel) {
        let chargeOneStep = ChargeOneStep(paymentGateway: gerencianetClient)
        
        chargeOneStep.execute(user: UserModel.shared, data: data) { [unowned self] result in
            
            switch result {
            case .success(let response):
                break
            case .failure(let error):
                if error == .unauthorized {
                    self.authenticateAndChargeOneStep(data: data)
                } else {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func authenticateAndChargeOneStep(data: ChargeOneStepModel) {
        let authenticateAndChargeOneStep = AuthenticateAndChargeOneStep(paymentGateway: gerencianetClient)
        
        authenticateAndChargeOneStep.execute(user: UserModel.shared, data: data) { [unowned self] result in
            
            switch result {
            case .success(let response):
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
