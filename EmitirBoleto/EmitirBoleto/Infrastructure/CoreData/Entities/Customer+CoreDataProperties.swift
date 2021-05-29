//
//  Customer+CoreDataProperties.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 18/05/21.
//
//

import Foundation
import CoreData


extension Customer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Customer> {
        return NSFetchRequest<Customer>(entityName: "Customer")
    }

    @NSManaged public var phoneNumber: String?
    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var cpf: String?
    @NSManaged public var juridicalPerson: JuridicalPerson?
    @NSManaged public var address: Address?

}

extension Customer : Identifiable {

}
