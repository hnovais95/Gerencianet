//
//  TestAuthenticationFactories.swift
//  DataTests
//
//  Created by Heitor Novais | Gerencianet on 23/06/21.
//

import Domain

func makeAuthenticationModel() -> AuthenticationModel {
    return AuthenticationModel(login: "any_client_id", password: "any_client_secret")
}

func makeAuthenticationResponse() -> AuthenticationResponseModel {
    return AuthenticationResponseModel(accessToken: "any_token", refreshToken: "any_refresh_token", expiresIn: 600, expireAt: "2022-01-01", tokenType: "any_token_type")
}
