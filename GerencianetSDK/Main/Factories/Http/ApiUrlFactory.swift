//
//  ApiUrlFactory.swift
//  Domain
//
//  Created by Heitor Novais | Gerencianet on 22/06/21.
//

import Foundation

public func makeApiUrl(path: String) -> URL {
    return URL(string: "\(Environment.variable(.apiBaseUrl))\(path)")!
}
