//
//  ChargeOneStepResponseModel.swift
//  Domain
//
//  Created by Heitor Novais | Gerencianet on 22/06/21.
//

public struct ChargeOneStepResponseModel: Serializable {
    
    public var code: Int
    public var data: DataResponse
    
    public init(code: Int, barcode: String, link: String, charge: String, expireAt: String, chargeId: Int, status: String, total: Int, payment: String) {
        self.code = code
        self.data = DataResponse(barcode: barcode, link: link, charge: charge, expireAt: expireAt, chargeId: chargeId, status: status, total: total, payment: payment)
    }
}

public struct DataResponse: Serializable {
    
    public var barcode: String
    public var link: String
    public var pdf: PdfResponse
    public var expireAt: String
    public var chargeId: Int
    public var status: String
    public var total: Int
    public var payment: String
    
    init(barcode: String, link: String, charge: String, expireAt: String, chargeId: Int, status: String, total: Int, payment: String) {
        self.barcode = barcode
        self.link = link
        self.pdf = PdfResponse(charge: charge)
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

public struct PdfResponse: Serializable {
    
    public var charge: String
    
    public init(charge: String) {
        self.charge = charge
    }
}
