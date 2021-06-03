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
        let sumValue = items?.map({ $0.value }).reduce(0, +) ?? 0
        print("SumValue: \(sumValue)")
        let discount = calculateDiscount()
        print("Discount: \(discount)")
        return Helper.getPrice(max(0, (sumValue - discount)))
    }
    
    private func calculateDiscount() -> Int {
        let sumValue = items?.map({ $0.value }).reduce(0, +) ?? 0
        
        var discount = 0.0
        if discountType == "currency" {
            discount += Double(discountValue) ?? 0.0
        } else
        {
            discount += (Double(discountValue) ?? 0.0) / 100 * Double(sumValue)
        }
        
        var conditionalDiscount = 0.0
        if discountType == "currency" {
            conditionalDiscount += Double(conditionalDiscountValue) ?? 0.0
        } else
        {
            conditionalDiscount += (Double(conditionalDiscountValue) ?? 0) / 100 * Double(sumValue)
        }
        
        return Int((discount + conditionalDiscount).rounded())
    }
    
    var isValid: Bool {
        return //validator.validate(.expireAt, expireAt)
            /*&&*/ validator.validate(.shippingValue, shippingValue)
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
