//
//  ChargeOneStepResponseModel.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

struct ChargeOneStepResponse: Serializable {
    
    private(set) var code: Int
    private(set) var data: ResponseData
    
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
    
    private(set) var barcode: String
    private(set) var link: String
    private(set) var pdf: Pdf
    private(set) var expireAt: String
    private(set) var chargeId: Int
    private(set) var status: String
    private(set) var total: Int
    private(set) var payment: String
    
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
    
    private(set) var charge: String
    
    init(_ charge: String) {
        self.charge = charge
    }
}

extension ResponseData {
    
    var shareableMessage: String {
        let message = """
        Olá, segue o boleto no valor de \(Helper.getPrice(total)).
        
        Acesse o boleto pelo link: \(link) ou pague usando o código de barras: \(barcode).
        """
        return message
    }
}
