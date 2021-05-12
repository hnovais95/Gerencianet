//
//  JuridicalPerson.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

struct JuridicalPersonModel: JuridicalEntity {
    let name: String
    let cpf: String
    let phoneNumber: String
    let email: String
    let address: Address
    let corporateName: String
    let cnpj: String
    
    init(_ name: String,
         _ cpf: String,
         _ phoneNumber: String,
         _ email: String,
         _ address: Address,
         _ corporateName: String,
         _ cnpj: String) {
        self.name = name
        self.cpf = cpf
        self.phoneNumber = phoneNumber
        self.email = email
        self.address = address
        self.corporateName = corporateName
        self.cnpj = cnpj
    }
}
