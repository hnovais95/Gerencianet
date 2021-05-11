//
//  AuthorizeResponse.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

struct AuthorizeResponse {
    let accessToken: String
    let refreshToken: String
    let expiresIn: Int
    let expireAt: String
    let tokenType: String
    
    init(_ accessToken: String,
         _ refreshToken: String,
         _ expiresIn: Int,
         _ expireAt: String,
         tokenType: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.expiresIn = expiresIn
        self.expireAt = expireAt
        self.tokenType = tokenType
    }
}
