//
//  Endpoints.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 14/05/21.
//

import Foundation
import Alamofire

enum GerencianetEndpoint: APIConfigurations {
    case authorize(user: UserDto)
    case chargeOneStep(token: String, chargeData: ChargeOneStepDto)
    
    var method: HTTPMethod {
        switch self {
        case .authorize, .chargeOneStep:
            return .post
        }
    }
    
    var url: URL {
        switch self {
        case .authorize:
            return URL(string: "\(Constants.HomologationServer.baseURL)authorize")!
        case .chargeOneStep:
            return URL(string: "\(Constants.HomologationServer.baseURL)charge/one-step")!
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .authorize(let user):
            return HeadersFactory.makeAuthorizeHeaders(clientId: user.clientId, clientSecret: user.clientSecret)
        case .chargeOneStep(let token, _):
            return HeadersFactory.makeChargeOneStepHeaders(accessToken: token)
        }
    }
    
    var body: [String: Any] {
        switch self {
        case .authorize:
            return BodyFactory.makeAuthorizeBody()
        case .chargeOneStep(_, let chargeData):
            return BodyFactory.makeChargeOneStepBody(parameters: chargeData)
        }
    }
}
