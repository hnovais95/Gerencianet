//
//  BankingBilletViewModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 01/06/21.
//

import Foundation

class BankingBilletViewModel {
    
    var validator = BankingBilletValidator()
    
    private(set) var customer: CustomerModel?
    private(set) var items: [ItemModel]?
    
    var expireAt: String = ""
    var shippingValue: String = ""
    var discountType: String = "currency" // default value
    var discountValue: String = ""
    var conditionalDiscountType: String = "currency" // default value
    var conditionalDiscountValue: String = ""
    var conditionalDiscountDeadline: String = ""
    var message: String = ""
    
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
    
    func setCustomer(_ customer: CustomerModel) {
        self.customer = customer
    }
    
    func setItems(_ items: [ItemModel]) {
        self.items = items
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
    
    func generateCharge() {
        let data = getChargeData()        
        
        let paymentGateway = Gerencianet(httpClient: AlamofireClient())
        let charge = ChargeOneStep(paymentGateway: paymentGateway)
        charge.execute(user: UserModel.shared, data: data) { _ in
            print("Executou cobrança.")
        }
    }
}
