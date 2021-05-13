//
//  NaturalPerson.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 12/05/21.
//

struct CustomerDto: Serializable {
    let name: String
    let cpf: String
    let birth: String
    let phoneNumber: String
    let email: String
    let address: Address
    let juridicalPerson: JuridicalPersonModel?
    
    init(_ person: CustomerModel) {
        self.name = person.name
        self.cpf = person.cpf
        self.birth = person.birth
        self.phoneNumber = person.phoneNumber
        self.email = person.email
        self.address = person.address
        self.juridicalPerson = person.juridicalPerson
    }
    
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
    
    static func == (lhs: CustomerDto, rhs: CustomerDto) -> Bool {
        return lhs.name == rhs.name && lhs.cpf == rhs.cpf
    }
    
    private enum CodingKeys: String, CodingKey {
        case name, cpf, phoneNumber = "phone_number", birth, email, address, juridicalPerson = "juridical_person"
    }
}
