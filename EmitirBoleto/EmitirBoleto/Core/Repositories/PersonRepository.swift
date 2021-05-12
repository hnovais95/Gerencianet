//
//  NaturalPersonRepository.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

protocol PersonRepository {
    func getAllNaturalPerson() -> [NaturalPersonModel]
    func getAllJuridicalPerson() -> [JuridicalPersonModel]
    func getAll() -> [Person]
    func save(_ person: NaturalPersonData)
    func save(_ person: JuridicalPersonData)
}
