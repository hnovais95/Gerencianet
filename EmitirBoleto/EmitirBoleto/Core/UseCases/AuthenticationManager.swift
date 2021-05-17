//
//  AuthenticatorManager.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 17/05/21.
//

import Foundation

class AuthenticationManager {
    private let paymentGateway: PaymentGateway
    private(set) var timer: RepeatingTimer?
    
    init(paymentGateway: PaymentGateway) {
        self.paymentGateway = paymentGateway
    }
    
    func startAuthenticationTimer(timeInterval: TimeInterval = Constants.Authentication.tokenUpdateInterval) {
        timer = RepeatingTimer(timeInterval: timeInterval)
        self.timer?.eventHandler = { [weak self] in
            self?.authenticate(user: UserModel.shared) { _ in return }
        }
        self.timer?.resume()
    }
    
    func authenticate(user: UserModel,
                 completion: @escaping (Result<AuthorizeResponse, APIError>) -> Void) {
        paymentGateway.authorize(user: UserDto(user)) { result in
            
            switch result {
            case .success(let response):
                user.setToken("\(response.tokenType) \(response.accessToken)")
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
