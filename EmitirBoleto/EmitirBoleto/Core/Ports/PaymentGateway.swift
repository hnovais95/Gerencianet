//
//  ChargeOneStepAPI.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

protocol PaymentGateway {
    func authorize(user: UserModel,
                   completion: @escaping (Result<AuthorizeResponse, DomainError>) -> Void)
    
    func createChargeOneStep(token: String,
                             data chargeData: ChargeOneStepDto,
                             completion: @escaping (Result<ChargeOneStepResponse, DomainError>) -> Void)
}
