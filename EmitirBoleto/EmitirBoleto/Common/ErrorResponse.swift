//
//  ErrorResponseModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 02/06/21.
//

struct ErrorResponse: Serializable {
    
    let code: Int
    let error: String
    let errorDescription: ErrorDescription
    
    var message: String? {
        guard let property = errorDescription.property.split(separator: #"/"#).first else {
            return nil
        }
        return "Propriedade \(property) inválida."
    }
    
    private enum CodingKeys: String, CodingKey {
        case code
        case error
        case errorDescription = "error_description"
    }
}

struct ErrorDescription: Serializable {
    
    let property: String
    let message: String
}
