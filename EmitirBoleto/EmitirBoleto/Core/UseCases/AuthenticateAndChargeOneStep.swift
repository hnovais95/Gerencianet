//
//  AuthenticateAndChargeOneStep.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 17/05/21.
//

import Foundation

class AuthenticateAndChargeOneStep {
    
    private let notificationCenter = NotificationCenter.default
    private let authenticateGroup = DispatchGroup()
    private let paymentGateway: PaymentGateway

    init(paymentGateway: PaymentGateway) {
        self.paymentGateway = paymentGateway
        self.notificationCenter.addObserver(self, selector: #selector(handleAuthentication(_:)), name: .authenticateSucess, object: nil)
        self.notificationCenter.addObserver(self, selector: #selector(handleAuthentication(_:)), name: .authenticateFailure, object: nil)
    }
    
    func execute(user: UserModel, data: ChargeOneStepModel) {
        let authenticate = Authenticate(paymentGateway: paymentGateway)
        authenticateGroup.enter()
        authenticate.execute(user: UserModel.shared)
        
        authenticateGroup.notify(queue: DispatchQueue.main) {
            let chargeOneStep = ChargeOneStep(paymentGateway: self.paymentGateway)
            chargeOneStep.execute(user: UserModel.shared, data: data)
        }
    }
    
    @objc
    private func handleAuthentication(_ notification: Notification) {
        authenticateGroup.leave()
    }
}

