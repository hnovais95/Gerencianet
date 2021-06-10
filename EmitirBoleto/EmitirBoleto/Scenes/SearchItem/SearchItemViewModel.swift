//
//  SearchItemViewModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 28/05/21.
//


class SearchItemViewModel {
    
    // MARK: - Model
    
    let itemRepository = CoreDataItemRepository()
    
    
    // MARK: - Methods
    
    func getAllItems() -> [ItemModel] {
        return itemRepository.getAll()
    }
}
