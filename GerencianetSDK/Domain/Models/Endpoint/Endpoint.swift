//
//  AuthenticationEndpoint.swift
//  Domain
//
//  Created by Heitor Novais | Gerencianet on 22/06/21.
//

import Foundation

public class Endpoint {
    
    public var url: URL
    public var method: String
    
    public init(url: URL, method: String) {
        self.url = url
        self.method = method
    }
}
