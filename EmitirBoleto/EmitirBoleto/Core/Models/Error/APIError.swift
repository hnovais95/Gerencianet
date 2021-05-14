//
//  NetworkError.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

import Foundation

enum APIError: Error {
    case noConnectivity
    case badRequest
    case serverError
    case unauthorized
    case forbidden
    case responseBuilder
}
