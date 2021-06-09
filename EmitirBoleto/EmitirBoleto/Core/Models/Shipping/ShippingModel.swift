//
//  ShippingModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

struct ShippingModel: Serializable {
    
    private(set) var name: String
    private(set) var value: Int
    
    init(_ name: String, _ value: Int) {
        self.name = name
        self.value = value
    }
}
