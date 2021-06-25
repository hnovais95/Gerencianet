//
//  Authorization.swift
//  DataTests
//
//  Created by Heitor Novais | Gerencianet on 23/06/21.
//

import Domain

func makeAuthorizationModel() -> AuthorizationModel {
    return AuthorizationModel(clientId: "any_client_id", clientSecret: "any_client_secret")
}

func makeAuthorizationResponse() -> AuthorizationResponseModel {
    return AuthorizationResponseModel(accessToken: "any_token", refreshToken: "any_refresh_token", expiresIn: 600, expireAt: "2022-01-01", tokenType: "any_token_type")
}
