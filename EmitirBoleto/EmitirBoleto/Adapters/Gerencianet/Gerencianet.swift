//
//  GerencianetGateway.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 12/05/21.
//

import Foundation

final class Gerencianet: PaymentGateway {
    private(set) var httpClient: HTTPPostClient
    
    public init(httpClient: HTTPPostClient) {
        self.httpClient = httpClient
    }
}
