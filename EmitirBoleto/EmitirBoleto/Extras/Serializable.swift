//
//  Serializable.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 12/05/21.
//

import Foundation

public protocol Serializable: Codable, Equatable {}

public extension Serializable {
    
    func toData() -> Data?  {
        return try? JSONEncoder().encode(self)
    }
    
    func toJson() -> [String: Any]?  {
        guard let data = self.toData() else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
}
