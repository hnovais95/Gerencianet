//
//  BankingBilletModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

struct BankingBilletModel: Serializable {
    
    private(set) var customer: CustomerModel?
    private(set) var expireAt: String
    
    init(customer: CustomerModel? = nil, expireAt: String) {
        self.customer = customer
        self.expireAt = expireAt
    }
    
    mutating func assignCustomer(_ customer: CustomerModel) {
        self.customer = customer
    }
    
    private enum CodingKeys: String, CodingKey {
        case customer
        case expireAt = "expire_at"
    }
}
