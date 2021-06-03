//
//  ChargeOneStepResponseModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

struct ChargeOneStepResponse: Serializable {
    
    let code: Int
    let data: ResponseData
    
    init(_ code: Int,
         _ barcode: String,
         _ link: String,
         _ charge: String,
         _ expireAt: String,
         _ chargeId: Int,
         _ status: String,
         _ total: Int,
         _ payment: String) {
        self.code = code
        self.data = ResponseData(barcode, link, charge, expireAt, chargeId, status, total, payment)
    }
}

struct ResponseData: Serializable {
    
    let barcode: String
    let link: String
    let pdf: Pdf
    let expireAt: String
    let chargeId: Int
    let status: String
    let total: Int
    let payment: String
    
    init(_ barcode: String,
         _ link: String,
         _ charge: String,
         _ expireAt: String,
         _ chargeId: Int,
         _ status: String,
         _ total: Int,
         _ payment: String) {
        self.barcode = barcode
        self.link = link
        self.pdf = Pdf(charge)
        self.expireAt = expireAt
        self.chargeId = chargeId
        self.status = status
        self.total = total
        self.payment = payment
    }
    
    private enum CodingKeys: String, CodingKey {
        case barcode
        case link
        case pdf
        case expireAt = "expire_at"
        case chargeId = "charge_id"
        case status
        case total
        case payment
    }
}

struct Pdf: Serializable {
    
    let charge: String
    
    init(_ charge: String) {
        self.charge = charge
    }
}
