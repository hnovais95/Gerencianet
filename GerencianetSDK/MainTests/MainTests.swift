//
//  MainTests.swift
//  MainTests
//
//  Created by Heitor Novais | Gerencianet on 22/06/21.
//

import Foundation
import XCTest
import Domain
import Data
import Infra
import Main

class MainTests: XCTestCase {

    func test_environment_variables() {
        let url = Environment.variable(.apiBaseUrl)
        let interval = Environment.variable(.tokenUpdateInterval)
        XCTAssertNotNil(url)
        XCTAssertNotNil(interval)
    }
    
    func test_auth() {
        let gerencianet = Gerencianet()
        
        
        let authorizationModel = AuthorizationModel(clientId: "Client_Id_e89b59870bcfc8285adc603662fafb60e403ccb1",
                                                    clientSecret: "Client_Secret_35f3fbcd52bfb705701e5cf769501d8b8c32f0a8")
        let exp = expectation(description: "waiting")
        gerencianet.authorize(model: authorizationModel) { result in
            switch result {
            case .success:
                XCTAssertNotNil(gerencianet.token)
            case .failure(let error):
                XCTFail("Expect success got \(error) instead")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
    
    func test_chargeOneStep() {
        let gerencianet = Gerencianet()
        let authorizationModel = AuthorizationModel(clientId: "Client_Id_e89b59870bcfc8285adc603662fafb60e403ccb1",
                                                    clientSecret: "Client_Secret_35f3fbcd52bfb705701e5cf769501d8b8c32f0a8")
        
        let exp = expectation(description: "waiting")
        gerencianet.authorize(model: authorizationModel) { result in
            switch result {
            case .success:
                XCTAssertNotNil(gerencianet.token)
            case .failure(let error):
                XCTFail("Expect success got \(error) instead")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
        
        let exp2 = expectation(description: "waiting")
        gerencianet.chargeOneStep(chargeOneStepRequest: makeChargeOneStepModel()) { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
            case .failure(let error):
                XCTFail("Expect success got \(error) instead")
            }
            exp2.fulfill()
        }
        wait(for: [exp2], timeout: 5)
    }
}
