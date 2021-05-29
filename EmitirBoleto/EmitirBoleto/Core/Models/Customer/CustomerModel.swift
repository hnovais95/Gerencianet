//
//  CostumerModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

struct CustomerModel: Serializable {
    
    private(set) var name: String
    private(set) var cpf: String
    private(set) var phoneNumber: String
    private(set) var email: String?
    private(set) var address: AddressModel?
    private(set) var juridicalPerson: JuridicalPersonModel?
    
    var isJuridicalPerson: Bool {
        return juridicalPerson != nil
    }
    
    init(_ name: String,
         _ cpf: String,
         _ phoneNumber: String,
         _ email: String? = nil,
         _ address: AddressModel? = nil,
         _ juridicalPerson: JuridicalPersonModel? = nil) {
        self.name = name
        self.cpf = cpf
        self.phoneNumber = phoneNumber
        self.email = email
        self.address = address
        self.juridicalPerson = juridicalPerson
    }
    
    static func == (lhs: CustomerModel, rhs: CustomerModel) -> Bool {
        return lhs.name == rhs.name && lhs.cpf == rhs.cpf
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case cpf
        case phoneNumber = "phone_number"
        case email
        case address
        case juridicalPerson = "juridical_person"
    }
}
