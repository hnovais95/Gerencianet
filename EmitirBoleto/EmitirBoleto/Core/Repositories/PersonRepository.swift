//
//  NaturalPersonRepository.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

protocol PersonRepository {
    func getAllNaturalPerson() -> [NaturalPerson]
    func getAllJuridicalPerson() -> [JuridicalPerson]
    func getAll() -> [Person]
    func save(_ person: NaturalPerson)
    func save(_ person: JuridicalPerson)
}
