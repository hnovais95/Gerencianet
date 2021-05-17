//
//  HTTPPostClient.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 14/05/21.
//

import Alamofire

protocol HTTPAlamofireClient {
    func request(to url: URL, method: HTTPMethod, with body: [String: Any], headers: HTTPHeaders,
              completion: @escaping (Result<Data?, APIError>) -> Void)
}
