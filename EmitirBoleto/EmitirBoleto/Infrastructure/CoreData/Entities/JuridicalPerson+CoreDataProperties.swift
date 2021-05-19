//
//  JuridicalPerson+CoreDataProperties.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 18/05/21.
//
//

import Foundation
import CoreData


extension JuridicalPerson {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JuridicalPerson> {
        return NSFetchRequest<JuridicalPerson>(entityName: "JuridicalPerson")
    }

    @NSManaged public var corporateName: String?
    @NSManaged public var cnpj: String?
    @NSManaged public var ofCustomer: Customer?

}

extension JuridicalPerson : Identifiable {

}
