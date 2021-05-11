//
//  NetworkError.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

import Foundation

enum NetworkError: Error {
    case badURL, badRequest, unauthorized
}
