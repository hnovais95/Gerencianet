//
//  ChargeOneStepAPI.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

protocol PaymentGateway {
    func createChargeOneStep(customer: Person,
                             data: ChargeData,
                             completionHandler: @escaping (Result<ChargeOneStepResponse, NetworkError>) -> Void)
}
