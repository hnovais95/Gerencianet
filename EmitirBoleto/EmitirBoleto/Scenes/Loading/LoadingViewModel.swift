//
//  LoadingViewModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 01/06/21.
//

import Foundation

class LoadingViewModel {
    
    private let notificationCenter = NotificationCenter.default
    
    private let gn: PaymentGateway
    var data: ChargeOneStepModel?
    var succeed: (ChargeOneStepResponse) -> () = { _ in }
    var failed: (String) -> () = { _ in }
    
    init() {
        self.gn = Gerencianet(httpClient: AlamofireClient())
        self.notificationCenter.addObserver(self, selector: #selector(chargeSuccess(_:)), name: .chargeSuccess, object: nil)
        self.notificationCenter.addObserver(self, selector: #selector(chargeFailure(_:)), name: .chargeFailure, object: nil)
    }
    
    deinit {
        self.notificationCenter.removeObserver(self, name: .chargeSuccess , object: nil)
        self.notificationCenter.removeObserver(self, name: .chargeFailure , object: nil)
    }
    
    @objc
    func chargeSuccess(_ notification: Notification) {
        guard let response = notification.object as? ChargeOneStepResponse else {
            failed(Constants.ErrorMessage.responseBuilding)
            return
        }
        succeed(response)
    }
    
    @objc
    func chargeFailure(_ notification: Notification) {
        if notification.object is NetworkError {
            if let networkError = notification.object as? NetworkError {
                
                switch networkError.error {
                case .unauthorized:
                    authenticateAndCharge()
                case .noConnectivity:
                    failed(Constants.ErrorMessage.noConnectivity)
                case .badRequest, .serverError:
                    
                    if let response = networkError.response {
                        failed(response.message ?? Constants.ErrorMessage.default)
                    } else {
                        failed(Constants.ErrorMessage.default)
                    }
                    
                default:
                    failed(Constants.ErrorMessage.default)
                }
                
            } else {
                failed(Constants.ErrorMessage.default)
            }
        } else if notification.object is GerencianetError {
            
            if let gnError = notification.object as? GerencianetError {
                switch gnError {
                case .responseBuilding:
                    failed(Constants.ErrorMessage.responseBuilding)
                }
            }
            
        }
        else {
            failed(Constants.ErrorMessage.default)
        }
    }
    
    func charge() {
        if let data = data {
            let charge = ChargeOneStep(paymentGateway: gn)
            charge.execute(user: UserModel.shared, data: data)
        } else {
            failed(Constants.ErrorMessage.default)
        }
    }
    
    func authenticateAndCharge() {
        if let data = data {
            let authenticateAndCharge = AuthenticateAndChargeOneStep(paymentGateway: gn)
            authenticateAndCharge.execute(user: UserModel.shared, data: data)
        } else {
            failed(Constants.ErrorMessage.default)
        }
    }
}