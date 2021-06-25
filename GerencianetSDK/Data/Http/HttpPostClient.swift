//
//  HttpPostClient.swift
//  Data
//
//  Created by Heitor Novais | Gerencianet on 22/06/21.
//

import Foundation

public protocol HttpPostClient {
    
    func post(to url: URL, method: String, withHeaders hearders: [[String: String]]?, withBody body: [String: Any]?, completion: @escaping (Result<Data?, HttpError>) -> Void)
}
