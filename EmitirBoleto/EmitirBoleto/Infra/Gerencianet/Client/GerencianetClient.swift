//
//  GerencianetClient.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 13/05/21.
//

import Alamofire

class GerencianetClient: PaymentGateway {    
    @discardableResult
    private func performRequest(route: GerencianetEndpoint, completion: @escaping (AFDataResponse<Any>?) -> Void) -> DataRequest {
        return AF.request(route).validate().responseJSON { (response: AFDataResponse<Any>?) in
            completion(response)
        }
    }
    
    private func getNetworkError(code: Int) -> NetworkError {
        switch code {
        case 401:
            return .unauthorized
        case 403:
            return .forbidden
        case 400...499:
            return .badRequest
        case 500...599:
            return .serverError
        default:
            return .noConnectivity
        }
    }

    func authorize(user: UserDto, completion: @escaping (AuthorizeResponse?, Error?) -> Void) {
        performRequest(route: .authorize(user: user)) { response in
            if response?.error == nil {
                if let data = response?.data, let utf8Text = String(data: data, encoding: .utf8) {
                    let json = utf8Text.data(using: .utf8)
                    
                    do {
                        let decoder = JSONDecoder()
                        let decodedJson = try decoder.decode(AuthorizeResponse.self, from: json!)
                        completion(decodedJson, nil)
                    } catch {
                        completion(nil, DomainError.unexpected)
                    }
                    
                    return
                }
            } else {
                print(response?.error as Any)
                
                if let errorCode = response?.error?.responseCode {
                    let networkError = self.getNetworkError(code: errorCode)
                    completion(nil, networkError)
                }
                
                return
            }                
        }
    }
    
    func createChargeOneStep(token: String,
                                    chargeData: ChargeOneStepDto,
                                    completion: @escaping (ChargeOneStepResponse?, Error?) -> Void) {
        performRequest(route: .createChargeOneStep(token: token, chargeData: chargeData)) { response in
            if response?.error == nil {
                if let data = response?.data, let utf8Text = String(data: data, encoding: .utf8) {
                    let json = utf8Text.data(using: .utf8)
                    
                    do {
                        let decoder = JSONDecoder()
                        let decodedJson = try decoder.decode(ChargeOneStepResponse.self, from: json!)
                        completion(decodedJson, nil)
                    } catch {
                        completion(nil, DomainError.unexpected)
                    }
                }
            } else {
                print(response?.error as Any)
                
                if let errorCode = response?.error?.responseCode {
                    let networkError = self.getNetworkError(code: errorCode)
                    completion(nil, networkError)
                }
            }
        }
    }
}

