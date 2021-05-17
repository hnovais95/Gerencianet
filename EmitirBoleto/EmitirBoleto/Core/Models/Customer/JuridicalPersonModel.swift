//
//  JuridicalPerson.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 12/05/21.
//

struct JuridicalPersonModel {
    let corporateName: String
    let cnpj: String
    
    init(_ corporateName: String, _ cnpj: String) {
        self.corporateName = corporateName
        self.cnpj = cnpj
    }
}
