//
//  ChargeOneStepModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 12/05/21.
//

struct ChargeOneStepModel: Serializable {
    
    private(set) var shippings: [ShippingModel]?
    private(set) var items: [ItemModel]
    private(set) var bankingBillet: BankingBilletModel
    
    init(bankingBillet: BankingBilletModel, items: [ItemModel], shippings: [ShippingModel]? = nil) {
        self.bankingBillet = bankingBillet
        self.items = items
        self.shippings = shippings
    }
    
    private enum CodingKeys: String, CodingKey {
        case items
        case shippings
        case bankingBillet = "banking_billet"
    }
}
