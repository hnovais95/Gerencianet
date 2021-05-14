//
//  ChargeOneStepDTO.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

struct ChargeOneStepDto: Serializable {
    let items: [ItemDto]
    let shippings: [ShippingDto]
    let bankingBillet: BankingBilletDto
    
    init(_ charge: ChargeOneStepModel) {
        self.init(charge.items, charge.shippings, charge.bankingBillet)
    }
    
    init(_ items: [ItemModel], _ shippings: [ShippingModel], _ bankingBillet: BankingBilletModel) {
        self.items = ChargeOneStepDto.mapper(itemsModel: items)
        self.shippings = ChargeOneStepDto.mapper(shippingsModel: shippings)
        self.bankingBillet = BankingBilletDto(bankingBillet)
    }
    
    private static func mapper(itemsModel: [ItemModel]) -> [ItemDto] {
        var items = [ItemDto]()
        for item in itemsModel {
            items.append(ItemDto(item))
        }
        return items
    }
    
    private static func mapper(shippingsModel: [ShippingModel]) -> [ShippingDto] {
        var shippings = [ShippingDto]()
        for shipping in shippingsModel {
            shippings.append(ShippingDto(shipping))
        }
        return shippings
    }
    
    private enum CodingKeys: String, CodingKey {
        case items = "items"
        case shippings = "shippings"
        case bankingBillet = "banking_billet"
    }
}
