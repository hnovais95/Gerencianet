//
//  AddItemVewModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 28/05/21.
//

class AddItemsViewModel {
    
    var customer: CustomerModel?
    var items: [ItemModel] = []
    var isValid: Bool {
        return items.count > 0
    }
}
