//
//  AlamofireAdapter.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 14/05/21.
//

import Foundation
import Alamofire

class AlamofireClient: HTTPClient {
    
    func request(to url: URL, method: HTTPMethod, with body: [String: Any], headers: HTTPHeaders,
              completion: @escaping (Result<Data?, NetworkError>) -> Void) {
        
        AF.request(url,
                   method: method,
                   parameters: body,
                   encoding: JSONEncoding.default,
                   headers: headers).responseData { responseData in
            
            guard let statusCode = responseData.response?.statusCode else {
                return completion(.failure(NetworkError(.noConnectivity)))
            }
                    
            switch responseData.result {
            case .failure:
                completion(.failure(NetworkError(.noConnectivity)))
            case .success(let data):
                switch statusCode {
                case 204:
                    completion(.success(data))
                case 200...299:
                    completion(.success(data))
                case 401:
                    completion(.failure(NetworkError(.unauthorized, data)))
                case 403:
                    completion(.failure(NetworkError(.forbidden, data)))
                case 400...499:
                    completion(.failure(NetworkError(.badRequest, data)))
                case 500...599:
                    completion(.failure(NetworkError(.serverError, data)))
                default:
                    completion(.failure(NetworkError(.unauthorized, data)))
                }
            }
        }
    }
}
