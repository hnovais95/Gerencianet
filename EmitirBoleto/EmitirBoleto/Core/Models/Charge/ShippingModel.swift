//
//  ShippingModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

struct ShippingModel: Serializable {
    let name: String
    let value: Int
    
    init(_ name: String, _ value: Int) {
        self.name = name
        self.value = value
    }
}
