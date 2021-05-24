//
//  Gerencianet+Authorize.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 14/05/21.
//


extension Gerencianet {
    
    func authorize(clientId: String,
                   clientSecret: String,
                   completion: @escaping (Result<AuthorizeResponseModel, APIError>) -> Void) {
        
        let route = GerencianetEndpoint.authorize(clientId: clientId, clientSecret: clientSecret)
        
        httpClient.request(to: route.url, method: route.method, with: route.body, headers: route.headers) { result in
            switch result {
            case .success(let data):
                if let response: AuthorizeResponseModel = data?.toModel() {
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
