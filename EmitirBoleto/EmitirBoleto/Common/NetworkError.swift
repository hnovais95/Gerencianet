//
//  NetworkError.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 02/06/21.
//

import Foundation

class NetworkError: Error {
    
    enum NetworkErrorType {
        case noConnectivity
        case badRequest
        case serverError
        case unauthorized
        case forbidden
    }
    
    var error: NetworkErrorType
    var response: ErrorResponse?
    
    init(_ error: NetworkErrorType, _ response: Data? = nil) {
        self.error = error
        self.response = response?.toModel() as ErrorResponse?
    }
}
