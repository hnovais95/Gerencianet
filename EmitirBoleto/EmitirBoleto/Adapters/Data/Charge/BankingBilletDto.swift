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
        self.init(bankingBillet.customer, bankingBillet.expireAt)
    }
    
    init(_ customer: CustomerModel? = nil, _ expireAt: String) {
        self.customer = customer != nil ? CustomerDto(customer!) : nil
        self.expireAt = expireAt
    }
    
    private enum CodingKeys: String, CodingKey {
        case customer = "customer"
        case expireAt = "expire_at"
    }
}
