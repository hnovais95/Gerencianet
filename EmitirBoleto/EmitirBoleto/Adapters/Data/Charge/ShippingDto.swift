//
//  ShippingDto.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 14/05/21.
//

struct ShippingDto: Serializable {
    let name: String
    let value: Int
    
    init(_ shipping: ShippingModel) {
        self.init(shipping.name, shipping.value)
    }
    
    init(_ name: String, _ value: Int) {
        self.name = name
        self.value = value
    }
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case value = "value"
    }
}

