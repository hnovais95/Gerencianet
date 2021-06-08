//
//  DiscountType.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 07/06/21.
//

enum DiscountType: String {
    case percentage = "%"
    case currency = "R$"
    
    var description: String {
        switch self {
        case .percentage:
            return "percentage"
        case .currency:
            return "currency"
        }
    }
}
