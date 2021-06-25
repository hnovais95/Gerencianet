//
//  TestFactories.swift
//  DataTests
//
//  Created by Heitor Novais | Gerencianet on 22/06/21.
//

import Foundation
import Domain

func makeInvalidData() -> Data {
    return Data("invalid_data".utf8)
}

func makeUrl() -> URL {
    return URL(string: "http://any-url.com")!
}

func makeEndpoint() -> Endpoint {
    return Endpoint(url: makeUrl(), method: "POST")
}
