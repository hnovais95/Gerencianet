//
//  NaturalPersonRepository.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

protocol CustomerRepository {
    func getAll() -> [CustomerModel]
    func save(_ person: CustomerDto)
}
