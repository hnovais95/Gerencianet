//
//  HTTPPostClient.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 12/05/21.
//

import Foundation

protocol HTTPPostClient {
    func post(to url: URL, with data: [String: Any], completion: @escaping (Result<Data?, NetworkError>) -> Void)
}
