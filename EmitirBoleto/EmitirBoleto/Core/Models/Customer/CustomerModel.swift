//
//  CostumerModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

struct CustomerModel: Serializable {
    
    let name: String
    let cpf: String
    let phoneNumber: String
    let birth: String
    let email: String
    let address: AddressModel?
    let juridicalPerson: JuridicalPersonModel?
    
    init(_ name: String,
         _ cpf: String,
         _ phoneNumber: String,
         _ birth: String,
         _ email: String,
         _ address: AddressModel? = nil,
         _ juridicalPerson: JuridicalPersonModel? = nil) {
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
    
    static func == (lhs: CustomerModel, rhs: CustomerModel) -> Bool {
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
