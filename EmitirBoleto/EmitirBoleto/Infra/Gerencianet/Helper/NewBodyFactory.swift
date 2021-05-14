//
//  NewBodyFactory.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 14/05/21.
//

import Foundation

class NewBodyFactory {
    static func makeAuthorizeBody() -> [String: Any]? {
        return ["grant_type": "client_credentials"]
    }
    
    static func makeChargeOneStepBody(parameters: ChargeOneStepDto) -> [String: Any]? {
        var items: Dictionary<String, Any>
        items = [
            "items": [
                [
                    "name": "Produto 1",
                    "value": 10000,
                    "amount": 2
                ]
            ]
        ]
        
        var shippings: Dictionary<String, Any>
        shippings = [
            "shippings": [
                [
                    "name": "Correios",
                    "value": 2000
                ]
            ]
        ]
        
        let payment: Dictionary<String, Any>
        payment = [
            "payment": [
                "banking_billet": [
                    "customer": [
                        "name": "Heitor Novais",
                        "cpf": "46282921678",
                        "phone_number": "31985624589",
                        "birth": "1995-12-01",
                        "email": "email@dominio.com",
                        "address": [
                           "number":1,
                           "street":"Rua JK",
                           "city":"Ouro Preto",
                           "complement":"A",
                           "zipcode":"35400000",
                           "neighborhood":"Bauxita",
                           "state":"MG"
                        ]
                    ],
                    "expire_at": "2021-05-15"
                ]
            ]
        ]
        
        var body = shippings
        body.merge(items) { (_, new) in new }
        body.merge(payment) { (_, new) in new }
        
        return body
    }
}
