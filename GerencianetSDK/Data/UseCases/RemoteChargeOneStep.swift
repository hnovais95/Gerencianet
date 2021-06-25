//
//  RemoteChargeOneStep.swift
//  Data
//
//  Created by Heitor Novais | Gerencianet on 22/06/21.
//

import Foundation
import Domain

struct Payment: Serializable {
    
    var bankingBillet: BankingBilletModel
    
    enum CodingKeys: String, CodingKey {
        case bankingBillet = "banking_billet"
    }
}

struct ChargeOneStepBodyModel: Serializable {
    
    var shippings: [ShippingModel]?
    var items: [ItemModel]
    var payment: Payment
}

public final class RemoteChargeOneStep: ChargeOneStep {
    
    private let endpoint: Endpoint
    private let httpClient: HttpPostClient
    
    public init(endpoint: Endpoint, httpClient: HttpPostClient) {
        self.endpoint = endpoint
        self.httpClient = httpClient
    }
    
    public func charge(token: String, model: ChargeOneStepModel, completion: @escaping (ChargeOneStep.Result) -> Void) {
        httpClient.post(to: endpoint.url, method: endpoint.method, withHeaders: makeChargeOneStepHeaders(token: token), withBody: makeChargeOneStepBody(model: model)) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let data):
                if let model: ChargeOneStepResponseModel = data?.toModel() {
                    completion(.success(model))
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure:
                completion(.failure(.unexpected))
            }
        }
    }
}

public func makeChargeOneStepHeaders(token: String) -> [[String: String]] {
    let authorizationHeader = [
        "name": "Authorization",
        "value": token
    ]
    
    let contentTypeHeader = [
        "name": "Content-Type",
        "value": "application/json"
    ]
    
    return [authorizationHeader, contentTypeHeader]
}

public func makeChargeOneStepBody(model: ChargeOneStepModel) -> [String: Any] {
    let body = ChargeOneStepBodyModel(shippings: model.shippings, items: model.items, payment: Payment(bankingBillet: model.bankingBillet))
    return body.toJson()!
}
