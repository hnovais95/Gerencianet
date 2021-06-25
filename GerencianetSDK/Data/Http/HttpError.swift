//
//  HttpError.swift
//  Data
//
//  Created by Heitor Novais | Gerencianet on 22/06/21.
//

import Foundation

public enum HttpError: Error {
    
    case noConnectivity
    case badRequest
    case serverError
    case unauthorized
    case forbidden
}

