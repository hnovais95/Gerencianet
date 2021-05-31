//
//  EntityMapper.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 18/05/21.
//

import CoreData

class EntityMapper {
    
    static func map<T>(from data: NSManagedObject, to type: T.Type) -> T? {
        
        switch type {
        case is CustomerModel.Type:
            if data is Customer {
                let data = data as! Customer
                
                var address: AddressModel?
                if data.address != nil {
                    address = AddressModel(data.address!.street!,
                                           Int(data.address!.number),
                                           data.address!.neighborhood!,
                                           data.address!.zipCode!,
                                           data.address!.city!,
                                           data.address!.complement,
                                           data.address!.state!)
                }
                
                var juridicalPerson: JuridicalPersonModel?
                if data.juridicalPerson != nil {
                    juridicalPerson = JuridicalPersonModel(data.juridicalPerson!.corporateName!,
                                                           data.juridicalPerson!.cnpj!)
                }
                
                return CustomerModel(data.name!,
                                     data.cpf!,
                                     data.phoneNumber!,
                                     data.email,
                                     address,
                                     juridicalPerson) as? T
            }
        case is ItemModel.Type:
            if data is Item {
                let data = data as! Item
                
                return ItemModel(data.name!, Int(data.value)) as? T
            }
        default:
            return nil
        }
        
        return nil
    }
}
