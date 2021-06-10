//
//  ChargeOneStepAPI.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

protocol PaymentGateway {
    
    func authorize(clientId: String,
                   clientSecret: String,
                   completion: @escaping (Result<AuthorizeResponse, Error>) -> Void)
    
    func createChargeOneStep(token: String,
                             data: ChargeOneStepModel,
                             completion: @escaping (Result<ChargeOneStepResponse, Error>) -> Void)
}
