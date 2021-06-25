//
//  Gerencianet+ChargeOneStep.swift
//  Main
//
//  Created by Heitor Novais | Gerencianet on 22/06/21.
//

import Domain
import Data

extension Gerencianet {
    
    public func chargeOneStep(chargeOneStepRequest: ChargeOneStepModel, completion: @escaping (ChargeOneStep.Result) -> Void) {
        guard let token = token else { return }
        let remoteChargeOneStep = makeRemoteChargeOneStep()
        remoteChargeOneStep.charge(token: token, model: chargeOneStepRequest) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
