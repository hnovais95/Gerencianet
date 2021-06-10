//
//  APIConfigurations.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 14/05/21.
//

import Alamofire

protocol APIConfigurations {
    
    var method: String { get }
    var url: URL { get }
    var headers: [[String: String]] { get }
    var body: [String: Any] { get }
}
