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
        static let gnOrange = UIColor.init(rgb: 0xF36F36)
        static let gnLightBlue = UIColor.init(rgb: 0x6BC7D1)
        static let gnDarkBlue = UIColor.init(rgb: 0x00B4C5)
        static let gnLightGray = UIColor.init(rgb: 0xB8B8B8)
        static let gnDarkGray = UIColor.init(rgb: 0x707070)
        static let gnBeige = UIColor.init(rgb: 0xC3A523)
        static let gnGreen = UIColor.init(rgb: 0x5BAC65)
        static let gnLightRed = UIColor.init(rgb: 0xB80610)
        static let gnDarkRed = UIColor.init(rgb: 0xBF5259)
    }
    
    struct ErrorMessage {
        static let `default` = "Falha inesperada! Por favor tente novamente."
        static let noConnectivity = "Falha de conexão. Verifique a conexão com a internet."
        static let responseBuilding = "Falha ao apresentar informações do boleto. Verifique o histório de emissões."
    }
    
    struct LocaleIdentifier {
        static let ptBR = "pt_BR"
    }
    
    struct Mask {
        static let cpf = "NNN.NNN.NNN-NN"
        static let cnpj = "NN.NNN.NNN/NNNN-NN"
        static let phoneNumber = "(NN) N NNNN-NNNN"
        static let zipCode = "NNNNN-NNN"
    }
}
