//
//  GerencianetEndpoints.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 14/05/21.
//

import Foundation
import Alamofire

enum GerencianetEndpoint: APIConfigurations {
    
    case authorize(clientId: String, clientSecret: String)
    case chargeOneStep(token: String, chargeData: ChargeOneStepModel)
    
    var method: String {
        switch self {
        case .authorize, .chargeOneStep:
            return "POST"
        }
    }
    
    var url: URL {
        switch self {
        case .authorize:
            return URL(string: "\(APIConstants.HomologationServer.baseURL)authorize")!
        case .chargeOneStep:
            return URL(string: "\(APIConstants.HomologationServer.baseURL)charge/one-step")!
        }
    }
    
    var headers: [[String: String]] {
        switch self {
        case .authorize(let clientId, let clientSecret):
            return HeadersFactory.makeAuthorizeHeaders(clientId: clientId, clientSecret: clientSecret)
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
