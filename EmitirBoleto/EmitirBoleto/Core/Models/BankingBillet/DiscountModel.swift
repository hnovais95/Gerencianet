//
//  Discount.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 01/06/21.
//

struct DiscountModel: Serializable {
    
    private(set) var type: String
    private(set) var value: Int
    
    init(type: String, value: Int) {
        self.type = type
        self.value = value
    }
}
