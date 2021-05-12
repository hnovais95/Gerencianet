//
//  CreateChargeStepOneBody.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 12/05/21.
//

import Foundation

class BodyFactory {
    static func makeCreateChargeOneStepBody(data: ChargeData) -> [String: Any] {
        let shippings: [String: Any] = [
            "shippings": data.toJson()?["shippings"] as Any
        ]
        
        let items: [String: Any] = [
            "items": data.toJson()?["items"] as Any
        ]
        
        let payment: [String: Any] = [
            "payment": [
                "banking_billet": data.bankingBillet?.toJson()?["customer"],
                "expire_at": data.bankingBillet?.toJson()?["expire_at"]
            ]
        ]
        
        var body = [String: Any]()
        body.merge(shippings) { (_, new) in new }
        body.merge(items) { (_, new) in new }
        body.merge(payment) { (_, new) in new }
        
        return body
    }
}
