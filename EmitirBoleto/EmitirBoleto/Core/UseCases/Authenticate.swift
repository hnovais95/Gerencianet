//
//  Authenticate.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 18/05/21.
//

import Foundation

class Authenticate {
    
    private let notificationCenter = NotificationCenter.default
    private let paymentGateway: PaymentGateway
    
    init(paymentGateway: PaymentGateway) {
        self.paymentGateway = paymentGateway
    }
    
    func execute(user: UserModel) {
        paymentGateway.authorize(clientId: user.clientId, clientSecret: user.clientSecret) { result in            
            switch result {
            case .success(let response):
                user.setToken("\(response.tokenType) \(response.accessToken)")
                self.notificationCenter.post(name: .authenticateSucess, object: response)
            case .failure(let error):
                self.notificationCenter.post(name: .authenticateFailure, object: error)
            }
        }
    }
}
