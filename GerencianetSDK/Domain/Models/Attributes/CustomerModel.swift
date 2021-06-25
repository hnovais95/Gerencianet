//
//  CustomerModel.swift
//  Domain
//
//  Created by Heitor Novais | Gerencianet on 22/06/21.
//

public struct CustomerModel: Serializable {
    
    public var name: String
    public var cpf: String
    public var phoneNumber: String
    public var email: String?
    public var address: AddressModel?
    public var juridicalPerson: JuridicalPersonModel?
    
    public init(name: String, cpf: String, phoneNumber: String, email: String? = nil, address: AddressModel? = nil, juridicalPerson: JuridicalPersonModel? = nil) {
        self.name = name
        self.cpf = cpf
        self.phoneNumber = phoneNumber
        self.email = email
        self.address = address
        self.juridicalPerson = juridicalPerson
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

public struct AddressModel: Serializable {
    
    public var street: String
    public var number: Int
    public var neighborhood: String
    public var zipcode: String
    public var city: String
    public var complement: String?
    public var state: String
    
    public init(street: String, number: Int, neighborhood: String, zipcode: String, city: String, complement: String? = nil, state: String) {
        self.street = street
        self.number = number
        self.neighborhood = neighborhood
        self.zipcode = zipcode
        self.city = city
        self.complement = complement
        self.state = state
    }
}

public struct JuridicalPersonModel: Serializable {
    
    public var corporateName: String
    public var cnpj: String
    
    public init(corporateName: String, cnpj: String) {
        self.corporateName = corporateName
        self.cnpj = cnpj
    }
    
    private enum CodingKeys: String, CodingKey {
        case corporateName = "corporate_name"
        case cnpj
    }
}
