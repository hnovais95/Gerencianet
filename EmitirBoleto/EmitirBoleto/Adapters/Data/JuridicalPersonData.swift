//
//  JuridicalPersonData.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 12/05/21.
//

struct JuridicalPersonData: Serializable {
    let name: String
    let cpf: String
    let phoneNumber: String
    let email: String
    let address: Address
    let corporateName: String
    let cnpj: String
    
    init(_ person: JuridicalPersonModel) {
        self.name = person.name
        self.cpf = person.cpf
        self.phoneNumber = person.phoneNumber
        self.email = person.email
        self.address = person.address
        self.corporateName = person.corporateName
        self.cnpj = person.cnpj
    }
    
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
    
    static func == (lhs: JuridicalPersonData, rhs: JuridicalPersonData) -> Bool {
        return lhs.name == rhs.name && lhs.cpf == rhs.cpf
    }
}

