//
//  AlamofireAdapter.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 14/05/21.
//

import Foundation
import Alamofire

class AlamofireClient: HTTPAlamofireClient {
    
    func request(to url: URL, method: HTTPMethod, with body: [String: Any], headers: HTTPHeaders,
              completion: @escaping (Result<Data?, APIError>) -> Void) {
        
        AF.request(url,
                   method: method,
                   parameters: body,
                   encoding: JSONEncoding.default,
                   headers: headers).responseData { responseData in
            
            guard let statusCode = responseData.response?.statusCode else {
                return completion(.failure(.noConnectivity))
            }
                    
            switch responseData.result {
            case .failure:
                completion(.failure(.noConnectivity))
            case .success(let data):
                switch statusCode {
                case 204:
                    completion(.success(nil))
                case 200...299:
                    completion(.success(data))
                case 401:
                    completion(.failure(.unauthorized))
                case 403:
                    completion(.failure(.forbidden))
                case 400...499:
                    completion(.failure(.badRequest))
                case 500...599:
                    completion(.failure(.serverError))
                default:
                    completion(.failure(.noConnectivity))
                }
            }
        }
    }
}
