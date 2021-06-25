//
//  HttpClientSpy.swift
//  DataTests
//
//  Created by Heitor Novais | Gerencianet on 22/06/21.
//

import Foundation
import Data

class HttpClientSpy: HttpClient {
    
    var urls = [URL]()
    var method: String?
    var body: [String: Any]?
    var completion: ((Result<Data?, HttpError>) -> Void)?
    
    func request(to url: URL, method: String, withHeaders hearders: [[String : String]]?, withBody body: [String : Any]?, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        self.urls.append(url)
        self.method = method
        self.body = body
        self.completion = completion
    }
    
    func completeWithError(_ error: HttpError) {
        completion?(.failure(error))
    }
    
    func completeWithData(_ data: Data) {
        completion?(.success(data))
    }
}
