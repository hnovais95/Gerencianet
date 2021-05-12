//
//  NaturalPerson.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 12/05/21.
//

struct NaturalPersonData: Serializable {
    let name: String
    let cpf: String
    let phoneNumber: String
    let email: String
    let address: Address
    
    init(_ person: NaturalPersonModel) {
        self.name = person.name
        self.cpf = person.cpf
        self.phoneNumber = person.phoneNumber
        self.email = person.email
        self.address = person.address
    }
    
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
    
    static func == (lhs: NaturalPersonData, rhs: NaturalPersonData) -> Bool {
        return lhs.name == rhs.name && lhs.cpf == rhs.cpf
    }
}
