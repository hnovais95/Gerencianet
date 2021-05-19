//
//  ItemRepository.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

protocol ItemRepository {
    
    func getAll() -> [ItemModel]
    func save(_ data: ItemModel)
}
