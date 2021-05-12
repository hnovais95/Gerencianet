//
//  ChargeOneStepAPI.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

protocol PaymentGateway {
    func createChargeOneStep(data: ChargeData,
                             completion: @escaping (Result<ChargeOneStepResponse, DomainError>) -> Void)
}
