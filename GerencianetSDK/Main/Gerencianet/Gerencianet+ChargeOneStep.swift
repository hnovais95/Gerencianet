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
        remoteChargeOneStep.execute(token: token, model: chargeOneStepRequest) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
