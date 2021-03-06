//
//  BankingBilletViewModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 01/06/21.
//

import Foundation

class BankingBilletViewModel {
    
    // MARK: - Model
    
    var customer: CustomerModel? // holding
    var items: [ItemModel]? // holding
    private var validator = BankingBilletValidator()
    
    
    // MARK: - Binding variables
    
    var expireAt: String = ""
    var shippingValue: String = ""
    var discountType: DiscountType = DiscountType.percentage
    var discountValue: String = ""
    var conditionalDiscountType: DiscountType = DiscountType.percentage
    var conditionalDiscountValue: String = ""
    var conditionalDiscountDeadline: String = ""
    var message: String = ""    
    
    var total: String {
        let sumItems = items?.map({ $0.value * $0.amount }).reduce(0, +) ?? 0
        let shipping = Int(shippingValue) ?? 0
        let discount = calculateDiscount()
        let total = max(0, (sumItems + shipping - discount))
        return Helper.getPrice(total)
    }
    
    var isValid: Bool {
        var isDiscountValid: Bool {
            if let _ = Int(discountValue) {
                return validator.validate(.discountType, discountType.description)
                    && validator.validate(.discountValue, discountValue)
            } else {
                return true
            }
        }
        
        var isConditionalDiscountValid: Bool {
            if let _ = Int(conditionalDiscountValue) {
                if !conditionalDiscountDeadline.isEmpty {
                    return validator.validate(.conditionalDiscountType, conditionalDiscountType.description)
                        && validator.validate(.conditionalDiscountValue, conditionalDiscountValue)
                        && validator.validate(.conditionalDiscountDeadline, conditionalDiscountDeadline)
                }
            } else {
                return true
            }
            return false
        }
        
        return validator.validate(.expireAt, expireAt)
            && validator.validate(.shippingValue, shippingValue)
            && validator.validate(.discountType, discountType.description)
            && isDiscountValid
            && isConditionalDiscountValid
            && validator.validate(.message, message)
    }
    
    
    // MARK: - Events
    
    var validatedField: (Bool, Int) -> () = { _,_  in }
    
    
    // MARK: - Methods
    
    private func calculateDiscount() -> Int {
        let sumItems = items?.map({ $0.value * $0.amount }).reduce(0, +) ?? 0
        var discount = 0.0
        
        if discountType == .currency {
            discount += Double(discountValue) ?? 0.0
        } else
        {
            discount += Double(sumItems) * (Double(discountValue) ?? 0.0) / 10000.0
        }
        
        if conditionalDiscountType == .currency {
            discount += Double(conditionalDiscountValue) ?? 0.0
        } else
        {
            discount += Double(sumItems) * (Double(conditionalDiscountValue) ?? 0.0) / 10000.0
        }
        
        return Int(discount.rounded())
    }
    
    private func getBankingBillet() -> BankingBilletModel {
        var discount: DiscountModel?
        if !discountValue.isEmpty {
            discount = DiscountModel(type: discountType.description, value: Int(discountValue) ?? 0)
        }
        
        var conditionalDiscount: ConditionalDiscountModel?
        if !conditionalDiscountValue.isEmpty {
            conditionalDiscount = ConditionalDiscountModel(type: discountType.description, value: Int(conditionalDiscountValue) ?? 0, untilDate: conditionalDiscountDeadline)
        }
        
        let message: String? = !self.message.isEmpty ? self.message : nil
        
        let bankingBillet = BankingBilletModel(customer: customer!, expireAt: expireAt, discount: discount, conditionalDiscount: conditionalDiscount, message: message)
        
        return bankingBillet
    }
    
    private func getShippings() -> [ShippingModel]? {
        if !shippingValue.isEmpty {
            return [ShippingModel("Frete", Int(shippingValue) ?? 0)]
        } else {
            return nil
        }
    }
    
    func validadeField(_ rawValue: Int, value: String) {
        let isValid = validator.validate(rawValue, value)
        validatedField(isValid, rawValue)
    }
    
    func getChargeData() -> ChargeOneStepModel {
        let bankingBillet = getBankingBillet()
        let shippings = getShippings()
        
        return ChargeOneStepModel(bankingBillet: bankingBillet, items: items!, shippings: shippings)
    }
}
