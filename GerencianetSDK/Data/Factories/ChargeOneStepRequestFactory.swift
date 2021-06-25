//
//  AuthenticationDataRequestFactory.swift
//  Data
//
//  Created by Heitor Novais | Gerencianet on 25/06/21.
//

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
