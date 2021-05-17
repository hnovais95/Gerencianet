//
//  Gerencianet.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 14/05/21.
//

import Foundation

final class Gerencianet: PaymentGateway {
    private(set) var httpClient: HTTPAlamofireClient
    
    public init(httpClient: HTTPAlamofireClient) {
        self.httpClient = httpClient
    }
}
