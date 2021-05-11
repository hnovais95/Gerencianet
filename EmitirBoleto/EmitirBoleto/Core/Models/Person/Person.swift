//
//  Person.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

protocol Person {
    var name: String { get }
    var cpf: String { get }
    var phoneNumber: String { get }
    var email: String { get }
    var address: Address { get }
}

protocol JuridicalEntity: Person {
    var corporateName: String { get }
    var cnpj: String { get }
}
