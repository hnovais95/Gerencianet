//
//  Itens.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

struct ItemModel: Serializable {
    let name: String
    let unitaryPrice: Int
    let amount: Int
    
    init(_ name: String, _ unitaryPrice: Int, _ amount: Int) {
        self.name = name
        self.unitaryPrice = unitaryPrice
        self.amount = amount
    }
}
