//
//  GerencianetEndpoint.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 13/05/21.
//

import Alamofire

enum GerencianetEndpoint: APIConfiguration {
    case authorize(user: UserDto)
    case createChargeOneStep(token: String, chargeData: ChargeOneStepDto)
    
    var method: HTTPMethod {
        switch self {
        case .authorize, .createChargeOneStep:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .authorize:
            return "authorize"
        case .createChargeOneStep:
            return "charge/one-step"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .authorize:
            return BodyFactory.makeAuthorizeBody()
        case .createChargeOneStep(_, let chargeData):
            return BodyFactory.makeChargeOneStepBody(parameters: chargeData)
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = Constants.HomologationServer.baseURL + path
    
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        switch self {
        case .authorize(let user):
            let authorization = "Basic" + " " + "\(user.clientId):\(user.clientSecret)".toBase64()
            urlRequest.addValue(authorization, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
            break
        case .createChargeOneStep(let token, _):
            let authorization = token
            urlRequest.addValue(authorization, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
            break
        }
        
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        debugPrint(urlRequest)
        return urlRequest
    }
}
