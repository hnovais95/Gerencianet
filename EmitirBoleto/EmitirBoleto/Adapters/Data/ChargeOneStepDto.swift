//
//  ChargeOneStepDTO.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

struct ChargeOneStepDto: Serializable {
    let items: [ItemModel]
    let shippings: [ShippingModel]
    let bankingBillet: BankingBilletDto?
    
    init(_ charge: ChargeOneStepModel) {
        self.items = charge.items
        self.shippings = charge.shippings
        if let bankingBillet = charge.bankingBillet {
            self.bankingBillet = BankingBilletDto(bankingBillet)
        } else {
            self.bankingBillet = nil
        }
    }
    
    init(_ itens: [ItemModel], _ shipping: [ShippingModel], bankingBillet: BankingBilletDto) {
        self.items = itens
        self.shippings = shipping
        self.bankingBillet = bankingBillet
    }
}
