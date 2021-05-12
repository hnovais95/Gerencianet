//
//  JuridicalEntity.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 12/05/21.
//

protocol JuridicalEntity: Person {
    var corporateName: String { get }
    var cnpj: String { get }
}
