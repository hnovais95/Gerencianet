//
//  Address.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

struct Address {
    let street: String
    let number: Int
    let complement: String
    let neighborhood: String
    let cep: String
    let state: String
    
    init(_ street: String,
         _ number: Int,
         _ complement: String,
         _ neighborhood: String,
         _ cep: String,
         _ state: String) {
        self.street = street
        self.number = number
        self.complement = complement
        self.neighborhood = neighborhood
        self.cep = cep
        self.state = state
    }
}
