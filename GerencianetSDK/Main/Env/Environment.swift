//
//  Environment.swift
//  Domain
//
//  Created by Heitor Novais | Gerencianet on 22/06/21.
//

import Foundation

public final class Environment {
    
    public enum EnvironmentVariables: String {
        case apiBaseUrl = "API_BASE_URL"
        case tokenUpdateInterval = "TOKEN_UPDATE_INTERVAL"
    }
    
    public static func variable(_ key: EnvironmentVariables) -> String {
        switch key {
        case .apiBaseUrl:
            return "https://sandbox.gerencianet.com.br/v1/"
        default:
            return "600"
        }
        
        //return Bundle(identifier: "Main")!.infoDictionary![key.rawValue] as! String
    }
}
