//
//  ItemModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

struct ItemModel: Serializable {
    
    let name: String
    let value: Int
    var amount: Int
    var total: Int {
        return value * amount
    }
    
    init(_ name: String, _ value: Int, _ amount: Int) {
        self.name = name
        self.value = value
        self.amount = amount
    }
    
    init(_ name: String, _ value: Int) {
        self.init(name, value, 0)
    }
    
    mutating func setAmount(_ amount: Int) {
        self.amount = amount
    }
    
    static func == (lhs: ItemModel, rhs: ItemModel) -> Bool {
        return lhs.name == rhs.name && lhs.value == rhs.value
    }
}
