//
//  Constants.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 17/05/21.
//

import Foundation

struct Constants {
    
    struct Authentication {
        static let clientId = "Client_Id_e89b59870bcfc8285adc603662fafb60e403ccb1"
        static let clientSecret = "Client_Secret_35f3fbcd52bfb705701e5cf769501d8b8c32f0a8"
        static let tokenUpdateInterval = TimeInterval(590)
    }
    
    struct EntityName {
        static let customer = "Customer"
        static let juridicalPerson = "JuridicalPerson"
        static let address = "Address"
        static let item = "Item"
    }
}
