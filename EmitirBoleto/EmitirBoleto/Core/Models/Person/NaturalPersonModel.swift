//
//  Costumer.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

struct NaturalPersonModel: Person {
    let name: String
    let cpf: String
    let phoneNumber: String
    let email: String
    let address: Address
    
    init(_ name: String,
         _ cpf: String,
         _ phoneNumber: String,
         _ email: String,
         _ address: Address) {
        self.name = name
        self.cpf = cpf
        self.phoneNumber = phoneNumber
        self.email = email
        self.address = address
    }
}
