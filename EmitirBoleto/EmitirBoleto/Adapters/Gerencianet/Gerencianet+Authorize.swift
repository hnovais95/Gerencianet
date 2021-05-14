//
//  Gerencianet+Authorize.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 14/05/21.
//


extension Gerencianet {
    func authorize(user: UserDto, completion: @escaping (Result<AuthorizeResponse, APIError>) -> Void) {
        
        let route = GerencianetEndpoint.authorize(user: user)
        
        httpClient.post(to: route.url, method: route.method, with: route.body, headers: route.headers) { result in
            switch result {
            case .success(let data):
                if let response: AuthorizeResponse = data?.toModel() {
                    completion(.success(response))
                } else {
                    completion(.failure(.responseBuilder))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
