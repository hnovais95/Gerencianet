//
//  CaseIterable+Extensions.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 28/05/21.
//

extension CaseIterable where Self: Equatable {
    
    mutating func next() {
        let allCases = Self.allCases
        guard let selfIndex = allCases.firstIndex(of: self) else { return }
        let nextIndex = Self.allCases.index(after: selfIndex)
        self = allCases[nextIndex == allCases.endIndex ? allCases.startIndex : nextIndex]
    }
}
