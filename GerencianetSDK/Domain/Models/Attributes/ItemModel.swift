//
//  ItemModel.swift
//  Domain
//
//  Created by Heitor Novais | Gerencianet on 22/06/21.
//

public struct ItemModel: Serializable {
    
    public var name: String
    public var value: Int
    public var amount: Int
    
    public init(name: String, value: Int, amount: Int) {
        self.name = name
        self.value = value
        self.amount = amount
    }
}
