//
//  ConditionalDiscount.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 01/06/21.
//

struct ConditionalDiscountModel: Serializable {
    
    private(set) var type: String
    private(set) var value: Int
    private(set) var untilDate: String
    
    init(type: String, value: Int, untilDate: String) {
        self.type = type
        self.value = value
        self.untilDate = untilDate
    }
    
    private enum CodingKeys: String, CodingKey {
        case type
        case value
        case untilDate = "until_date"
    }
}
