//
//  BankingBilletModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

struct BankingBilletModel: Serializable {
    
    private(set) var customer: CustomerModel
    private(set) var expireAt: String
    private(set) var discount: DiscountModel?
    private(set) var conditionalDiscount: ConditionalDiscountModel?
    private(set) var message: String?
    
    init(customer: CustomerModel,
         expireAt: String,
         discount: DiscountModel? = nil,
         conditionalDiscount: ConditionalDiscountModel? = nil,
         message: String? = nil) {
        self.customer = customer
        self.expireAt = expireAt
        self.discount = discount
        self.conditionalDiscount = conditionalDiscount
        self.message = message
    }
    
    mutating func assignCustomer(_ customer: CustomerModel) {
        self.customer = customer
    }
    
    private enum CodingKeys: String, CodingKey {
        case customer
        case expireAt = "expire_at"
        case discount
        case conditionalDiscount = "conditional_discount"
        case message
    }
}
