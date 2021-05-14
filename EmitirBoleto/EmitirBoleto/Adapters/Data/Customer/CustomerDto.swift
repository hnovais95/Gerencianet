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
    let juridicalPerson: JuridicalPersonDto?
    
    init(_ customer: CustomerModel) {        
        self.init(customer.name,
                  customer.cpf,
                  customer.phoneNumber,
                  customer.birth,
                  customer.email,
                  customer.address,
                  customer.juridicalPerson)
    }
    
    init(_ name: String,
         _ cpf: String,
         _ phoneNumber: String,
         _ birth: String,
         _ email: String,
         _ address: Address,
         _ juridicalPerson: JuridicalPersonModel? = nil) {
        self.name = name
        self.cpf = cpf
        self.phoneNumber = phoneNumber
        self.birth = birth
        self.email = email
        self.address = address
        self.juridicalPerson = juridicalPerson != nil ? JuridicalPersonDto(juridicalPerson!) : nil
    }
    
    static func == (lhs: CustomerDto, rhs: CustomerDto) -> Bool {
        return lhs.name == rhs.name && lhs.cpf == rhs.cpf
    }
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case cpf = "cpf"
        case phoneNumber = "phone_number"
        case birth = "birth"
        case email = "email"
        case address = "address"
        case juridicalPerson = "juridical_person"
    }
}
