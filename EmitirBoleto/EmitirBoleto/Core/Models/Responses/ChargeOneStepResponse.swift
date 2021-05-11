//
//  Feedback.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

import Foundation

struct ChargeOneStepResponse {
    let customer: String
    let expireAt: String
    let value: Decimal
    let barCode: String
    let sharedLink: String
    let pdfLink: String
    
    init(_ customer: String,
         _ expireAt: String,
         _ value: Decimal,
         _ barCode: String,
         _ sharedLink: String,
         _ pdfLink: String) {
        self.customer = customer
        self.expireAt = expireAt
        self.value = value
        self.barCode = barCode
        self.sharedLink = sharedLink
        self.pdfLink = pdfLink
    }
}
