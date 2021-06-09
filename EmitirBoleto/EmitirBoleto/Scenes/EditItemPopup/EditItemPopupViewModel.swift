//
//  EditItemPopupViewModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 31/05/21.
//

import Foundation

class EditItemPopupViewModel {
    
    let validator = ItemValidator()
    
    var oldItem: ItemModel?
    
    var name: String = ""
    var value: String = ""
    var amount: String = ""
    
    var isValid: Bool {
        return validator.validate(.name, name)
            && validator.validate(.value, value)
            && validator.validate(.amount, amount)
    }
    
    var validatedField: (Bool, Int) -> () = { _,_  in }
    
    func validadeField(_ rawValue: Int, value: String) {
        let isValid = validator.validate(rawValue, value)
        validatedField(isValid, rawValue)
    }
    
    func getItem() -> ItemModel {
        return ItemModel(name, (value as NSString).integerValue, (amount as NSString).integerValue)
    }
}
