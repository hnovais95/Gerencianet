//
//  ScheduleAuthentication.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 17/05/21.
//

import Foundation

class ScheduleAuthentication {
    
    private let paymentGateway: PaymentGateway
    private var timer: RepeatingTimer?
    
    init(paymentGateway: PaymentGateway) {
        self.paymentGateway = paymentGateway
    }
    
    func execute(timeInterval: TimeInterval = Constants.Authentication.tokenUpdateInterval) {
        timer = RepeatingTimer(timeInterval: timeInterval)
        self.timer?.eventHandler = { [unowned self] in
            let authenticate = Authenticate(paymentGateway: self.paymentGateway)
            authenticate.execute(user: UserModel.shared)
        }
        self.timer?.resume()
    }
}
