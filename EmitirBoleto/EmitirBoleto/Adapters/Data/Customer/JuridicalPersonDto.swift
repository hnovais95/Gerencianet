//
//  JuridicalPersonDto.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 14/05/21.
//

struct JuridicalPersonDto: Serializable {
    let corporateName: String
    let cnpj: String
    
    init(_ juridicalPerson: JuridicalPersonModel) {
        self.init(juridicalPerson.corporateName, cnpj: juridicalPerson.cnpj)
    }
    
    init(_ corporateName: String, cnpj: String) {
        self.corporateName = corporateName
        self.cnpj = cnpj
    }
    
    private enum CodingKeys: String, CodingKey {
        case corporateName = "corporate_name"
        case cnpj = "cnpj"
    }
}
