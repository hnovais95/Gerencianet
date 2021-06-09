//
//  GerencianetError.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 02/06/21.
//

enum GerencianetError: Error {
    case responseBuilding
    
    var description: String {
        switch self {
        case .responseBuilding:
            return "Erro ao construir objeto de resposta."
        }
    }
}
