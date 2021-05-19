//
//  Address+CoreDataProperties.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 18/05/21.
//
//

import Foundation
import CoreData


extension Address {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Address> {
        return NSFetchRequest<Address>(entityName: "Address")
    }

    @NSManaged public var zipCode: String?
    @NSManaged public var neighborhood: String?
    @NSManaged public var number: Int16
    @NSManaged public var street: String?
    @NSManaged public var city: String?
    @NSManaged public var complement: String?
    @NSManaged public var state: String?
    @NSManaged public var ofCustomer: Customer?

}

extension Address : Identifiable {

}
