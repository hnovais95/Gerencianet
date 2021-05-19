//
//  JuridicalPersonModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 12/05/21.
//

struct JuridicalPersonModel: Serializable {
    
    let corporateName: String
    let cnpj: String
    
    init(_ corporateName: String, _ cnpj: String) {
        self.corporateName = corporateName
        self.cnpj = cnpj
    }
    
    private enum CodingKeys: String, CodingKey {
        case corporateName = "corporate_name"
        case cnpj
    }
}
