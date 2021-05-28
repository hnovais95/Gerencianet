//
//  SearchItemViewModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 28/05/21.
//


class SearchItemViewModel {
    
    let itemRepository = CoreDataItemRepository()
    
    func getAllItems() -> [ItemModel] {
        return itemRepository.getAll()
    }
}
