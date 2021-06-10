//
//  HTTPPostClient.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 14/05/21.
//

import Foundation

protocol HTTPClient {
    func request(to url: URL, method: String, with body: [String: Any], headers: [[String: String]],
              completion: @escaping (Result<Data?, Error>) -> Void)
}
