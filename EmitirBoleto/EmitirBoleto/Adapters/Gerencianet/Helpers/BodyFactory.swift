//
//  BodyFactory.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 14/05/21.
//

import Foundation

class BodyFactory {
    static func makeAuthorizeBody() -> [String: Any] {
        return ["grant_type": "client_credentials"]
    }
    
    static func makeChargeOneStepBody(parameters: ChargeOneStepModel) -> [String: Any] {
        let shippings: [String: Any] = [
            "shippings": parameters.toJson()?["shippings"] as Any
        ]
        let items: [String: Any] = [
            "items": parameters.toJson()?["items"] as Any
        ]
        let payment: [String: Any] = [
            "payment": [
                "banking_billet": [
                    "customer": parameters.bankingBillet.toJson()?["customer"],
                    "expire_at": parameters.bankingBillet.toJson()?["expire_at"]
                ]
            ]
        ]
        
        var body = [String: Any]()
        body.merge(shippings) { (_, new) in new }
        body.merge(items) { (_, new) in new }
        body.merge(payment) { (_, new) in new }
        
        return body
    }
}
