//
//  BankingBillet.swift
//  Domain
//
//  Created by Heitor Novais | Gerencianet on 22/06/21.
//

public struct BankingBilletModel: Serializable {
    
    public var customer: CustomerModel
    public var expireAt: String
    public var discount: DiscountModel?
    public var conditionalDiscount: ConditionalDiscountModel?
    public var message: String?
    
    public init(customer: CustomerModel, expireAt: String, discount: DiscountModel? = nil, conditionalDiscount: ConditionalDiscountModel? = nil, message: String? = nil) {
        self.customer = customer
        self.expireAt = expireAt
        self.discount = discount
        self.conditionalDiscount = conditionalDiscount
        self.message = message
    }
    
    private enum CodingKeys: String, CodingKey {
        case customer
        case expireAt = "expire_at"
        case discount
        case conditionalDiscount = "conditional_discount"
        case message
    }
}

public struct DiscountModel: Serializable {
    
    public var type: String
    public var value: Int
    
    public init(type: String, value: Int) {
        self.type = type
        self.value = value
    }
}

public struct ConditionalDiscountModel: Serializable {
    
    public var type: String
    public var value: Int
    public var untilDate: String
    
    public init(type: String, value: Int, untilDate: String) {
        self.type = type
        self.value = value
        self.untilDate = untilDate
    }
    
    private enum CodingKeys: String, CodingKey {
        case type
        case value
        case untilDate = "until_date"
    }
}
