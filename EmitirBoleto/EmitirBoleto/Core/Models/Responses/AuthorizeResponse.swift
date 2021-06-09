//
//  AuthorizeResponseModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

struct AuthorizeResponse: Serializable {
    
    private(set) var accessToken: String
    private(set) var refreshToken: String
    private(set) var expiresIn: Int
    private(set) var expireAt: String
    private(set) var tokenType: String
    
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
