//
//  HTTPPostClient.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 14/05/21.
//

import Alamofire

protocol HTTPRequestClient {
    func post(to url: URL, method: HTTPMethod, with body: [String: Any], headers: HTTPHeaders,
              completion: @escaping (Result<Data?, APIError>) -> Void)
}
