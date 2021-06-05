//
//  BankingBilletViewModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 01/06/21.
//

import Foundation

class BankingBilletViewModel {
    
    private var validator = BankingBilletValidator()
    
    var customer: CustomerModel?
    var items: [ItemModel]?
    
    var expireAt: String = ""
    var shippingValue: String = ""
    var discountType: String = "percentage"
    var discountValue: String = ""
    var conditionalDiscountType: String = "percentage"
    var conditionalDiscountValue: String = ""
    var conditionalDiscountDeadline: String = ""
    var message: String = ""
    
    var total: String {
        let itemsValue = items?.map({ $0.value }).reduce(0, +) ?? 0
        let discount = calculateDiscount()
        let total = max(0, (itemsValue - discount))
        return Helper.getPrice(total)
    }
    
    private func calculateDiscount() -> Int {
        var discount = 0.0
        let itemsValue = items?.map({ $0.value }).reduce(0, +) ?? 0
        
        if discountType == "currency" {
            discount += Double(discountValue) ?? 0.0
        } else
        {
            discount += Double(itemsValue) * (Double(discountValue) ?? 0.0) / 10000.0
        }
        
        if conditionalDiscountType == "currency" {
            discount += Double(conditionalDiscountValue) ?? 0.0
        } else
        {
            discount += Double(itemsValue) * (Double(conditionalDiscountValue) ?? 0.0) / 10000.0
        }
        
        return Int(discount.rounded())
    }
    
    var isValid: Bool {
        return validator.validate(.expireAt, expireAt)
            && validator.validate(.shippingValue, shippingValue)
            && validator.validate(.discountType, discountType)
            && validator.validate(.discountValue, discountValue)
            && validator.validate(.conditionalDiscountType, conditionalDiscountType)
            && validator.validate(.contitionalDiscountValue, conditionalDiscountValue)
            && validator.validate(.contitionalDiscountDeadline, conditionalDiscountDeadline)
    }
    
    var validatedField: (Bool, Int) -> () = { _,_  in }
    
    func validadeField(_ rawValue: Int, value: String) {
        let isValid = validator.validate(rawValue, value)
        validatedField(isValid, rawValue)
    }
    
    private func getBankingBillet() -> BankingBilletModel {
        var discount: DiscountModel?
        if !discountValue.isEmpty {
            discount = DiscountModel(type: discountType, value: Int(discountValue) ?? 0)
        }
        
        var conditionalDiscount: ConditionalDiscountModel?
        if !conditionalDiscountValue.isEmpty {
            conditionalDiscount = ConditionalDiscountModel(type: discountType, value: Int(discountValue) ?? 0, untilDate: conditionalDiscountDeadline)
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
    
    func getChargeData() -> ChargeOneStepModel {
        let bankingBillet = getBankingBillet()
        let shippings = getShippings()
        
        return ChargeOneStepModel(bankingBillet: bankingBillet, items: items!, shippings: shippings)
    }
}
