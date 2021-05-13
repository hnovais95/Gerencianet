//
//  CreateChargeStepOneBody.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 12/05/21.
//

import Foundation

class BodyFactory {
    static func makeGetAuthorizeBody() -> Data? {
        let body = ["grant_type": "client_credentials"]
        
        return try? JSONSerialization.data(withJSONObject: body)
    }
    
    static func makeChargeOneStepBody(parameters: ChargeOneStepDto) -> Data? {
        let shippings: [String: Any] = [
            "shippings": parameters.toJson()?["shippings"] as Any
        ]
        
        let items: [String: Any] = [
            "items": parameters.toJson()?["items"] as Any
        ]
        
        let payment: [String: Any] = [
            "payment": [
                "banking_billet": parameters.bankingBillet?.toJson()?["customer"],
                "expire_at": parameters.bankingBillet?.toJson()?["expire_at"]
            ]
        ]
        
        var body = shippings
        body.merge(items) { (_, new) in new }
        body.merge(payment) { (_, new) in new }
        
        return try? JSONSerialization.data(withJSONObject: body)
    }
}
