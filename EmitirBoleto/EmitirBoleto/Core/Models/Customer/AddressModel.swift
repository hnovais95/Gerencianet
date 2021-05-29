//
//  AddressModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

struct AddressModel: Serializable {
    
    private(set) var street: String
    private(set) var number: Int
    private(set) var neighborhood: String
    private(set) var zipCode: String
    private(set) var city: String
    private(set) var complement: String?
    private(set) var state: String
    
    init(_ street: String,
         _ number: Int,
         _ neighborhood: String,
         _ zipCode: String,
         _ city: String,
         _ complement: String? = nil,
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
