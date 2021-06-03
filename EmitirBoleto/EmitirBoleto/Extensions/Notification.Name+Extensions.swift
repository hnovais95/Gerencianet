//
//  Notification.Name+Extensions.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 02/06/21.
//

import Foundation

extension Notification.Name {
    
    static var chargeSuccess: Notification.Name {
          return .init(rawValue: "Charge.success") }
    
    static var chargeFailure: Notification.Name {
          return .init(rawValue: "Charge.failure") }
    
    static var authenticateSucess: Notification.Name {
          return .init(rawValue: "Authenticate.sucess") }
    
    static var authenticateFailure: Notification.Name {
          return .init(rawValue: "Authenticate.failure") }
}
