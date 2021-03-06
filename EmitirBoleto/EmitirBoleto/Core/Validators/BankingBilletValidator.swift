//
//  BankingBilletValidator.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 01/06/21.
//

struct BankingBilletValidator: Validator {
    
    enum BankingBilletValidityType: Int {
        case expireAt, shippingValue, discountType, discountValue, conditionalDiscountType,
             conditionalDiscountValue, conditionalDiscountDeadline, message
    }
    
    func validate(_ rawValue: Int, _ value: String) -> Bool {
        guard let type = BankingBilletValidityType(rawValue: rawValue) else { return false }
        return validate(type, value)
    }
    
    func validate(_ type: BankingBilletValidityType, _ value: String) -> Bool {
        switch type {
        case .expireAt:
            return validadeRegex("^[12][0-9]{3}-(?:0[1-9]|1[0-2])-(?:0[1-9]|[12][0-9]|3[01])$", value)
        case .discountType, .conditionalDiscountType:
            return (value == "percentage") || (value == "currency")
        case .shippingValue, .discountValue, .conditionalDiscountValue:
            return (value == "") || ((Int(value) != nil) && (Int(value)! > 99))
        case .conditionalDiscountDeadline:
            return (value == "") || validadeRegex("^[12][0-9]{3}-(?:0[1-9]|1[0-2])-(?:0[1-9]|[12][0-9]|3[01])$", value)
        case .message:
            return validadeRegex("^[^\n]{0,100}(\n[^\n]{0,100}){0,3}$", value)
        }
    }
}

