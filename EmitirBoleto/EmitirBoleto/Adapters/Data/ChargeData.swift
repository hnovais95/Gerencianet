//
//  ChargeOneStepDTO.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

struct ChargeData: Serializable {
    let itens: [ItemModel]
    let shippings: [ShippingModel]
    let bankingBillet: BankingBilletModel?
    
    init(_ charge: ChargeModel) {
        self.itens = charge.itens
        self.shippings = charge.shippings
        self.bankingBillet = charge.bankingBillet
    }
    
    init(_ itens: [ItemModel], _ shipping: [ShippingModel], bankingBillet: BankingBilletModel) {
        self.itens = itens
        self.shippings = shipping
        self.bankingBillet = bankingBillet
    }
}
