//
//  ChargeOneStepModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 12/05/21.
//

struct ChargeOneStepModel: Serializable {
    
    private(set) var items: [ItemModel]
    private(set) var shippings: [ShippingModel]
    private(set) var bankingBillet: BankingBilletModel
    
    init(bankingBillet: BankingBilletModel) {
        self.items = [ItemModel]()
        self.shippings = [ShippingModel]()
        self.bankingBillet = bankingBillet
    }
    
    mutating func add(item: ItemModel) {
        items.append(item)
    }
    
    mutating func add(shipping: ShippingModel) {
        shippings.append(shipping)
    }
    
    private enum CodingKeys: String, CodingKey {
        case items
        case shippings
        case bankingBillet = "banking_billet"
    }
}
