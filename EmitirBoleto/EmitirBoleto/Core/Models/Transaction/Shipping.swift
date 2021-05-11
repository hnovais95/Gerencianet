//
//  Shipping.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

import Foundation

struct Shipping {
    let name: String
    let value: Decimal
    let amount: Int
    
    init(_ name: String, _ value: Decimal, _ amount: Int) {
        self.name = name
        self.value = value
        self.amount = amount
    }
}
