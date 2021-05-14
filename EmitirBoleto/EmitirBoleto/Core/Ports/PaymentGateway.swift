//
//  ChargeOneStepAPI.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

protocol PaymentGateway {
    func authorize(user: UserDto, completion: @escaping (AuthorizeResponse?, Error?) -> Void)
    
    func createChargeOneStep(token: String,
                                    chargeData: ChargeOneStepDto,
                                    completion: @escaping (ChargeOneStepResponse?, Error?) -> Void)
}
