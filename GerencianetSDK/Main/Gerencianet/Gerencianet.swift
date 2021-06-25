//
//  Gerencianet.swift
//  Main
//
//  Created by Heitor Novais | Gerencianet on 22/06/21.
//

import Foundation
import Domain
import Data

public class Gerencianet {
    
    var token: String?
    
    func saveToken(tokenType: String, accessToken: String) {
        token = "\(tokenType) \(accessToken)"
    }
}
