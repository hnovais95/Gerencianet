//
//  Shipping.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

struct ShippingModel: Serializable {
    let name: String
    let value: Int
    let amount: Int
    
    init(_ name: String, _ value: Int, _ amount: Int) {
        self.name = name
        self.value = value
        self.amount = amount
    }
}
