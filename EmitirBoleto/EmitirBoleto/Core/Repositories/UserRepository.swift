//
//  UserRepository.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

protocol UserRepository {
    func getUser(clientID: String) -> User
    func getToken(clientID: String) -> String
    func save(_ user: UserData)
}
