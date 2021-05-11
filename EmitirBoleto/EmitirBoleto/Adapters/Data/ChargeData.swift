//
//  ChargeOneStepDTO.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

struct ChargeData {
    let itens: [Item]
    let shipping: [Shipping]
    let bankingBillet: BankingBillet
    
    init(_ itens: [Item], _ shipping: [Shipping], bankingBillet: BankingBillet) {
        self.itens = itens
        self.shipping = shipping
        self.bankingBillet = bankingBillet
    }
}
