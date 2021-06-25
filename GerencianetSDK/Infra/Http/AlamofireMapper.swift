//
//  AlamofireMapper.swift
//  Infra
//
//  Created by Heitor Novais | Gerencianet on 22/06/21.
//

import Foundation
import Alamofire

class AlamofireMapper {
    
    static func toHTTPMethod(method: String) -> HTTPMethod {
        return HTTPMethod(rawValue: method)
    }
    
    static func toHTTPHeaders(headers: [[String: String]]?) -> HTTPHeaders? {
        guard let headers = headers else { return nil }
        var httpHeaders: [HTTPHeader] = []
        for header in headers {
            guard let name = header["name"], let value = header["value"] else { return nil }
            httpHeaders.append(HTTPHeader(name: name, value: value))
        }
        return HTTPHeaders(httpHeaders)
    }
}
