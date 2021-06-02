//
//  Constants.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 17/05/21.
//

import Foundation
import UIKit

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
    
    struct Color {
        static let laranja = UIColor.init(rgb: 0xF36F36)
        static let azulClaro = UIColor.init(rgb: 0x6BC7D1)
        static let azulEscuro = UIColor.init(rgb: 0x00B4C5)
        static let cinzaClaro = UIColor.init(rgb: 0xB8B8B8)
        static let cinzaEscuro = UIColor.init(rgb: 0x707070)
        static let bege = UIColor.init(rgb: 0xC3A523)
        static let verde = UIColor.init(rgb: 0x5BAC65)
        static let vermelhoClaro = UIColor.init(rgb: 0xB80610)
        static let vermelhoEscuro = UIColor.init(rgb: 0xBF5259)
    }
}
