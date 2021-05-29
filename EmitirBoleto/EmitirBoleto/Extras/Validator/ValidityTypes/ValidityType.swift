//
//  ValidityType.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 28/05/21.
//

import Foundation

protocol ValidityType {
    
    init?(rawValue: Int)
    
    var min: Int { get }
    var max: Int { get }
    var regex: String { get }
}
