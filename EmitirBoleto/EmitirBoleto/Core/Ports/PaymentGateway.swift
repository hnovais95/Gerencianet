//
//  ChargeOneStepAPI.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

protocol PaymentGateway {
    func authorize(user: UserDto, completion: @escaping (Result<AuthorizeResponse, APIError>) -> Void)
    
    func createChargeOneStep(token: String,
                                    data: ChargeOneStepDto,
                                    completion: @escaping (Result<ChargeOneStepResponse, APIError>) -> Void)
}
