//
//  AddItemPopupViewModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 28/05/21.
//

import Foundation

class AddItemPopupViewModel {
    
    // MARK: - Model
    
    let validator = ItemValidator()
    

    // MARK: - Binding variables
    
    var name: String = ""
    var value: String = ""
    var amount: String = "1" // default minimum value
    
    var isValid: Bool {
        return validator.validate(.name, name)
            && validator.validate(.value, value)
            && validator.validate(.amount, amount)
    }
    
    
    // MARK: - Events
    
    var validatedField: (Bool, Int) -> () = { _,_  in }
    
    
    // MARK: - Methods
    
    func validadeField(_ rawValue: Int, value: String) {
        let isValid = validator.validate(rawValue, value)
        validatedField(isValid, rawValue)
    }
    
    func getItem() -> ItemModel {
        return ItemModel(name, (value as NSString).integerValue, (amount as NSString).integerValue)
    }
}
