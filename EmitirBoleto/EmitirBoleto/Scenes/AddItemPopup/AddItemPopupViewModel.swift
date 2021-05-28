//
//  AddItemPopupViewModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 28/05/21.
//

import Foundation

class AddItemPopupViewModel {
    
    private let validator = Validator()
    
    var name: String = ""
    var value: String = ""
    var amount: String = ""
    
    var validatedField: (Bool, Int) -> () = { _,_  in }
    
    func getItem() -> ItemModel {
        return ItemModel(name, (value as NSString).integerValue, (amount as NSString).integerValue)
    }
}

extension AddItemPopupViewModel {
    
    var isValid: Bool {
        return true
    }
}
