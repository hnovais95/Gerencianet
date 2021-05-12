//
//  Boleto.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

struct BankingBilletModel {
    var customer: CustomerModel?
    let expireAt: String
    
    init(customer: CustomerModel? = nil, expireAt: String) {
        self.customer = customer
        self.expireAt = expireAt
    }
    
    mutating func assignCustomer(_ customer: CustomerModel) {
        self.customer = customer
    }
}
