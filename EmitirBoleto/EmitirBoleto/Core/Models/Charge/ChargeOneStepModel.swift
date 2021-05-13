//
//  charge.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 12/05/21.
//

struct ChargeOneStepModel {
    private(set) var items: [ItemModel]
    private(set) var shippings: [ShippingModel]
    private(set) var bankingBillet: BankingBilletModel?
    
    init(bankingBillet: BankingBilletModel) {
        self.items = [ItemModel]()
        self.shippings = [ShippingModel]()
        self.bankingBillet = bankingBillet
    }
    
    mutating func add(item: ItemModel) {
        items.append(item)
    }
    
    mutating func add(shipping: ShippingModel) {
        shippings.append(shipping)
    }
    
    func getValue() -> Int {
        var value = 0
        value += shippings.map({ $0.value }).reduce(0, +)
        value += items.map({ $0.value * $0.amount }).reduce(0, +)
        return value
    }
}
