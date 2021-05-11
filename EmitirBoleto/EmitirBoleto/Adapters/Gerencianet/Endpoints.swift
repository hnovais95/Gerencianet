//
//  Routes.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

import Foundation

final class Endpoints {
    private static let base: String = "https://sandbox.gerencianet.com.br"
    
    static let authorize: String = base + "/v1/authorize"
    static let chargeOneStep: String = base + "/v1/charge/one-step"
}
