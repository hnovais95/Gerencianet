//
//  ModelFactory.swift
//  DataTests
//
//  Created by Heitor Novais | Gerencianet on 22/06/21.
//

import Domain

func makeItemsModel() -> [ItemModel] {
    return [ItemModel(name: "Monitor LCD", value: 5000, amount: 1)]
}

func makeAddressModel() -> AddressModel {
    return AddressModel(street: "Av. JK", number: 10, neighborhood: "Bauxita", zipcode: "35500971", city: "Ouro Preto", state: "MG")
}

func makeCustomerModel() -> CustomerModel {
    return CustomerModel(name: "Gorbadoc OldBuck", cpf: "94271564656", phoneNumber: "31944916523", email: "email_cliente@servidor.com.br", address: makeAddressModel(), juridicalPerson: nil)
}

func makeBankingBilletBilletModel() -> BankingBilletModel {
    return BankingBilletModel(customer: makeCustomerModel(), expireAt: "2021-12-01")
}

func makeChargeOneStepModel() -> ChargeOneStepModel {
    return ChargeOneStepModel(items: makeItemsModel(), bankingBillet: makeBankingBilletBilletModel())
}

func makeAddressJson() -> [String: Any] {
    return [
        "number": 10,
        "state": "MG",
        "street": "Av. JK",
        "city": "Ouro Preto",
        "zipcode": "35500971",
        "neighborhood": "Bauxita"
    ] as [String : Any]
}

func makeCustomerJson() -> [String: Any] {
    return [
        "email": "email_cliente@servidor.com.br",
        "cpf": "94271564656",
        "name": "Gorbadoc OldBuck",
        "phone_number": "31944916523",
        "address": makeAddressJson()
    ] as [String : Any]
}

func makeBankingBilletJson() -> [String: Any] {
    return [
        "expire_at": "2021-12-01",
        "customer": makeCustomerJson()
    ] as [String : Any]
}

func makePaymentJson() -> [String: Any] {
    return [
        "banking_billet": makeBankingBilletJson()
    ] as [String : Any]
}

func makeItemsJson() -> [[String: Any]] {
    return [[
        "name": "Monitor LCD",
        "value": 5000,
        "amount": 1
    ] as [String : Any]]
}

func makeChargeOneStepBodyJson() -> [String: Any] {
    return [
        "payment": makePaymentJson(),
        "items": makeItemsJson()
    ]
}

func makeChargeOneStepResponse() -> ChargeOneStepResponseModel {
    return ChargeOneStepResponseModel(code: 99999, barcode: "any_barcode", link: "any_link", charge: "any_charge", expireAt: "2022-01-01", chargeId: 99999, status: "any_status", total: 9999, payment: "any_payment")
}
