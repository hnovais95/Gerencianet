//
//  InsertCustomerViewModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 26/05/21.
//

import Foundation

struct InsertCustomerViewModel {
    
    dynamic var name: String = ""
    dynamic var cpf: String = ""
    dynamic var corporateName: String?
    dynamic var cnpj: String?
    dynamic var phoneNumber: String = ""
    dynamic var email: String = ""
    dynamic var street: String?
    dynamic var number: Int?
    dynamic var complement: String?
    dynamic var neighborhood: String?
    dynamic var zipcode: String?
    dynamic var state: String?
    dynamic var city: String?
}
