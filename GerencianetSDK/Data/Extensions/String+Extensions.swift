//
//  String+Extensions.swift
//  Domain
//
//  Created by Heitor Novais | Gerencianet on 22/06/21.
//

import Foundation

extension String {

    public func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}
