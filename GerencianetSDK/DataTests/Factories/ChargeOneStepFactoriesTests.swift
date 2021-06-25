//
//  ChargeOneStepBodyFactory.swift
//  DataTests
//
//  Created by Heitor Novais | Gerencianet on 23/06/21.
//

import Foundation
import XCTest
import Domain
import Data

class ChargeOneStepDataFactoryTests: XCTestCase {
    
    func test_if_conversion_from_item_to_json_is_correct() {
        let sut = makeItemsModel()[0].toJson()!
        XCTAssertTrue(NSDictionary(dictionary: sut).isEqual(to: NSDictionary(dictionary: makeItemsJson()[0])))
    }
    
    func test_if_conversion_from_address_to_json_is_correct() {
        let sut = makeAddressModel().toJson()!
        XCTAssertTrue(NSDictionary(dictionary: sut).isEqual(to: NSDictionary(dictionary: makeAddressJson())))
    }
    
    func test_if_conversion_from_customer_to_json_is_correct() {
        let sut = makeCustomerModel().toJson()!
        XCTAssertTrue(NSDictionary(dictionary: sut).isEqual(to: NSDictionary(dictionary: makeCustomerJson())))
    }
    
    func test_if_conversion_from_bankingBillet_to_json_is_correct() {
        let sut = makeBankingBilletBilletModel().toJson()!
        XCTAssertTrue(NSDictionary(dictionary: sut).isEqual(to: NSDictionary(dictionary: makeBankingBilletJson())))
    }
    
    func test_if_conversion_from_chargeOneStepBody_to_json_is_correct() {
        let sut = makeChargeOneStepBody(model: makeChargeOneStepModel())
        XCTAssertTrue(NSDictionary(dictionary: sut).isEqual(to: NSDictionary(dictionary: makeChargeOneStepBodyJson())))
    }
}
