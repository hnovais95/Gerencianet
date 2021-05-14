//
//  Item.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 14/05/21.
//

struct ItemDto: Serializable {
    let name: String
    let value: Int
    let amount: Int
    
    init(_ item: ItemModel) {
        self.init(item.name, item.value, item.amount)
    }
    
    init(_ name: String, _ value: Int, _ amount: Int) {
        self.name = name
        self.value = value
        self.amount = amount
    }
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case value = "value"
        case amount = "amount"
    }
}
