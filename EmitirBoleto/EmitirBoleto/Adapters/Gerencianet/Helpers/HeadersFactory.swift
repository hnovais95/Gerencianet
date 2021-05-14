//
//  HeadersFactory.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 14/05/21.
//

import Alamofire
import Foundation

class HeadersFactory {
    static func makeAuthorizeHeaders(clientId: String, clientSecret: String) -> HTTPHeaders {
        var headers = [HTTPHeader]()
        headers.append(HTTPHeader(name: "Authorization", value: "Basic" + " " + "\(clientId):\(clientSecret)".toBase64()))
        return HTTPHeaders(headers)
    }
    
    static func makeChargeOneStepHeaders(accessToken: String) -> HTTPHeaders {
        var headers = [HTTPHeader]()
        headers.append(HTTPHeader(name: "Authorization", value: accessToken))
        headers.append(HTTPHeader(name: "Content-Type", value: "application/json"))
        return HTTPHeaders(headers)
    }
}
