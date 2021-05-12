//
//  ChargeOneStepDTO.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

struct ChargeData: Serializable {
    let items: [ItemModel]
    let shippings: [ShippingModel]
    let bankingBillet: BankingBilletData?
    
    init(_ charge: ChargeModel) {
        self.items = charge.items
        self.shippings = charge.shippings
        if let bankingBillet = charge.bankingBillet {
            self.bankingBillet = BankingBilletData(bankingBillet)
        } else {
            self.bankingBillet = nil
        }
    }
    
    init(_ itens: [ItemModel], _ shipping: [ShippingModel], bankingBillet: BankingBilletData) {
        self.items = itens
        self.shippings = shipping
        self.bankingBillet = bankingBillet
    }
}
