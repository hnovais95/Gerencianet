//
//  AddItemVewModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 28/05/21.
//

class AddItemsViewModel {
    
    private(set) var customer: CustomerModel?
    private(set) var items: [ItemModel] = []
    
    var isValid: Bool {
        return items.count > 0
    }
    
    func addItem(_ item: ItemModel) {
        if let index = items.firstIndex(of: item) {
            items[index].increaseAmount()
        } else {
            items.append(item)
        }
    }
    
    func removeItem(_ item: ItemModel) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
    
    func editItem(_ oldItem: ItemModel, _ newItem: ItemModel) {
        if let oldIndex = items.firstIndex(of: oldItem) {
            items[oldIndex] = newItem
        }
        
        if items.filter({ $0 == newItem }).count > 1 {
            let firstIndex = items.firstIndex(of: newItem)!
            let lastIndex = items.lastIndex(of: newItem)!
            items[firstIndex].increaseAmount(items[lastIndex].amount)
            items.remove(at: lastIndex)
        }
    }
    
    func setCustomer(_ customer: CustomerModel) {
        self.customer = customer
    }
}
