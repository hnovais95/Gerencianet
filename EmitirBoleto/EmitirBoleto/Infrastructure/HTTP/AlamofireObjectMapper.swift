//
//  AlamofireObjectMapper.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 10/06/21.
//

import Foundation
import Alamofire

class AlamofireObjectMapper {

    static func map<T>(from data: Any, to type: T.Type) -> T? {
        
        switch type {
        case is HTTPMethod.Type:
            if let method = data as? String {
                
                return HTTPMethod(rawValue: method) as? T
            }
        case is HTTPHeaders.Type:
            if let headers = data as? [[String: String]] {
                
                var httpHeaders: [HTTPHeader] = []
                for header in headers {
                    guard let name = header["name"], let value = header["value"] else { return nil }
                    httpHeaders.append(HTTPHeader(name: name, value: value))
                }
                
                return HTTPHeaders(httpHeaders) as? T
            }
        default:
            return nil
        }
        return nil
    }
    
}
