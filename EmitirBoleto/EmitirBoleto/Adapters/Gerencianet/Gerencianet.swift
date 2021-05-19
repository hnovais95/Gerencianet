//
//  Gerencianet.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 14/05/21.
//

final class Gerencianet: PaymentGateway {
    
    private(set) var httpClient: HTTPAlamofireClient
    
    init(httpClient: HTTPAlamofireClient) {
        self.httpClient = httpClient
    }
}
