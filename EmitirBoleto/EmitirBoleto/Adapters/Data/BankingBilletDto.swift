//
//  BankingBilletData.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 12/05/21.
//

struct BankingBilletDto: Serializable {
    var customer: CustomerDto?
    let expireAt: String
    
    init(_ bankingBillet: BankingBilletModel) {
        if let customer = bankingBillet.customer {
            self.customer = CustomerDto(customer)
        }
        self.expireAt = bankingBillet.expireAt
    }
    
    init(customer: CustomerDto? = nil, expireAt: String) {
        self.customer = customer
        self.expireAt = expireAt
    }
    
    private enum CodingKeys: String, CodingKey {
        case customer, expireAt = "expire_at"
    }
}
