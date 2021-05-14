//
//  AuthorizeResponse.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

struct AuthorizeResponse: Serializable {
    let accessToken: String
    let refreshToken: String
    let expiresIn: Int
    let expireAt: String
    let tokenType: String
    
    init(_ accessToken: String,
         _ refreshToken: String,
         _ expiresIn: Int,
         _ expireAt: String,
         _ tokenType: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.expiresIn = expiresIn
        self.expireAt = expireAt
        self.tokenType = tokenType
    }
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
        case expireAt = "expire_at"
        case tokenType = "token_type"
    }
}
