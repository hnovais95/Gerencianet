//
//  ChargeOneStepModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 12/05/21.
//

struct ChargeOneStepModel: Serializable {
    
    private(set) var bankingBillet: BankingBilletModel
    private(set) var items: [ItemModel]?
    private(set) var shippings: [ShippingModel]?
    
    init(bankingBillet: BankingBilletModel, items: [ItemModel], shippings: [ShippingModel]? = nil) {
        self.bankingBillet = bankingBillet
        self.items = items
        self.shippings = shippings
    }
    
    mutating func add(item: ItemModel) {
        if items == nil {
            items = []
        }
        items?.append(item)
    }
    
    mutating func add(shipping: ShippingModel) {
        if shippings == nil {
            shippings = []
        }
        shippings?.append(shipping)
    }
    
    private enum CodingKeys: String, CodingKey {
        case items
        case shippings
        case bankingBillet = "banking_billet"
    }
}
