//
//  Costumer.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

struct CustomerModel {
    let name: String
    let cpf: String
    let birth: String
    let phoneNumber: String
    let email: String
    let address: Address
    let juridicalPerson: JuridicalPersonModel?
    
    init(_ name: String,
         _ cpf: String,
         _ phoneNumber: String,
         _ birth: String,
         _ email: String,
         _ address: Address) {
        self.name = name
        self.cpf = cpf
        self.birth = birth
        self.phoneNumber = phoneNumber
        self.email = email
        self.address = address
        self.juridicalPerson = nil
    }
    
    init(_ name: String,
         _ cpf: String,
         _ phoneNumber: String,
         _ birth: String,
         _ email: String,
         _ address: Address,
         _ juridicalPerson: JuridicalPersonModel) {
        self.name = name
        self.cpf = cpf
        self.birth = birth
        self.phoneNumber = phoneNumber
        self.email = email
        self.address = address
        self.juridicalPerson = juridicalPerson
    }
    
    func isJuridicalPerson() -> Bool {
        return juridicalPerson != nil
    }
}
