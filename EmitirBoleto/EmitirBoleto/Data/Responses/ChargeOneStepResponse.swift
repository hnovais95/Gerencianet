//
//  Feedback.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

struct ChargeOneStepResponse: Serializable {
    let customer: String
    let expireAt: String
    let value: Int
    let barCode: String
    let sharedLink: String
    let pdfLink: String
    
    init(_ customer: String,
         _ expireAt: String,
         _ value: Int,
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
