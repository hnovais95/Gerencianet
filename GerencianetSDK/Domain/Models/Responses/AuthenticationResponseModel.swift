//
//  AuthenticationResponseModel.swift
//  Domain
//
//  Created by Heitor Novais | Gerencianet on 23/06/21.
//

public struct AuthenticationResponseModel: Serializable {
    
    public var accessToken: String
    public var refreshToken: String
    public var expiresIn: Int
    public var expireAt: String
    public var tokenType: String
    
    public init(accessToken: String, refreshToken: String, expiresIn: Int, expireAt: String, tokenType: String) {
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
