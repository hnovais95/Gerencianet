//
//  AddressDto.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 17/05/21.
//

import CoreData

struct AddressDto: Serializable {
    let street: String
    let number: Int
    let neighborhood: String
    let zipCode: String
    let city: String
    let complement: String
    let state: String
    
    init(_ address: AddressModel) {
        self.init(address.street, address.number, address.neighborhood, address.zipCode, address.city, address.complement, address.state)
    }
    
    init(_ street: String,
         _ number: Int,
         _ neighborhood: String,
         _ zipCode: String,
         _ city: String,
         _ complement: String,
         _ state: String) {
        self.street = street
        self.number = number
        self.neighborhood = neighborhood
        self.zipCode = zipCode
        self.city = city
        self.complement = complement
        self.state = state
    }
    
    private enum CodingKeys: String, CodingKey {
        case street
        case number
        case neighborhood
        case zipCode = "zipcode"
        case city
        case complement
        case state
    }
}
