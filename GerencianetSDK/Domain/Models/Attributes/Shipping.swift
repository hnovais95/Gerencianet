//
//  Shipping.swift
//  Domain
//
//  Created by Heitor Novais | Gerencianet on 22/06/21.
//

public struct ShippingModel: Serializable {
    
    public var name: String
    public var value: Int
    
    public init(name: String, value: Int) {
        self.name = name
        self.value = value
    }
}
