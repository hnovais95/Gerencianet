//
//  ChargeOneStep.swift
//  Domain
//
//  Created by Heitor Novais | Gerencianet on 22/06/21.
//

import Foundation

public protocol ChargeOneStep {
    
    typealias Result = Swift.Result<ChargeOneStepResponseModel, GnError>
    func execute(token: String, model: ChargeOneStepModel, completion: @escaping (ChargeOneStep.Result) -> Void)
}

public struct ChargeOneStepModel {
    
    public var shippings: [ShippingModel]?
    public var items: [ItemModel]
    public var bankingBillet: BankingBilletModel
    
    public init(shippings: [ShippingModel]? = nil, items: [ItemModel], bankingBillet: BankingBilletModel) {
        self.shippings = shippings
        self.items = items
        self.bankingBillet = bankingBillet
    }
}
