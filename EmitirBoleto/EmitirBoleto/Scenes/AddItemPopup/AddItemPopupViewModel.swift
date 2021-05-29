//
//  AddItemPopupViewModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 28/05/21.
//

import Foundation

class AddItemPopupViewModel {
    
    var name: String = ""
    var value: String = ""
    var amount: String = ""
    
    var validatedField: (Bool, Int) -> () = { _,_  in }
    
    func validadeField(_ rawValueFieldType: Int, value: String) {
        guard let type = ItemValidityType(rawValue: rawValueFieldType) else { return }
        
        let result = Validator.isValid(type, value: value)
        validatedField(result, rawValueFieldType)
    }
    
    func getItem() -> ItemModel {
        return ItemModel(name, (value as NSString).integerValue, (amount as NSString).integerValue)
    }
}

extension AddItemPopupViewModel {
    
    var isValid: Bool {
        return Validator.isValid(ItemValidityType.name, value: name)
            && Validator.isValid(ItemValidityType.value, value: value)
            && Validator.isValid(ItemValidityType.amount, value: amount)
    }
}
