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
        var body = [String: Any]()
        
        // MARK: - Items
        
        let items: [String: Any] = [
            "items": parameters.toJson()?["items"] as Any
        ]
        body.merge(items) { (_, new) in new }
        
        // MARK: - Shippings
        
        if let _ = parameters.shippings {
            let shippings: [String: Any] = [
                "shippings": parameters.toJson()?["shippings"] as Any
            ]
            body.merge(shippings) { (_, new) in new }
        }
        
        // MARK: - Banking Billet
        
        var bankingBillet: [String: Any] = [
            "customer": parameters.bankingBillet.toJson()?["customer"] as Any,
            "expire_at": parameters.bankingBillet.toJson()?["expire_at"] as Any
        ]
        
        // MARK: - Optional objects
        
        if let _ = parameters.bankingBillet.discount {
            let discount: [String: Any] = [
                "discount": parameters.bankingBillet.toJson()?["discount"] as Any
            ]
            bankingBillet.merge(discount) { (_, new) in new }
        }
        
        if let _ = parameters.bankingBillet.conditionalDiscount {
            let conditionalDiscount: [String: Any] = [
                "conditional_discount": parameters.bankingBillet.toJson()?["conditional_discount"] as Any
            ]
            bankingBillet.merge(conditionalDiscount) { (_, new) in new }
        }
        
        if let message = parameters.bankingBillet.message {
            let message: [String: Any] = [
                "message": message
            ]
            bankingBillet.merge(message) { (_, new) in new }
        }
        
        // MARK: - Payment
        
        let payment: [String: Any] = [
            "payment": ["banking_billet": bankingBillet]
        ]
        body.merge(payment) { (_, new) in new }
        
        return body
    }
}
