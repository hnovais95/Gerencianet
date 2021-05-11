//
//  Itens.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

import Foundation

struct Item {
    let name: String
    let unitaryPrice: Decimal
    let amount: Int
    
    init(_ name: String, _ unitaryPrice: Decimal, _ amount: Int) {
        self.name = name
        self.unitaryPrice = unitaryPrice
        self.amount = amount
    }
}
