//
//  ErrorResponseModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 02/06/21.
//

struct ErrorResponse: Serializable {
    
    private(set) var code: Int
    private(set) var error: String
    private(set) var errorDescription: ErrorDescription
    
    var message: String? {
        guard let property = errorDescription.property.split(separator: #"/"#).first else {
            return nil
        }
        return "Propriedade \"\(property)\" inválida."
    }
    
    private enum CodingKeys: String, CodingKey {
        case code
        case error
        case errorDescription = "error_description"
    }
}

struct ErrorDescription: Serializable {
    
    private(set) var property: String
    private(set) var message: String
}
