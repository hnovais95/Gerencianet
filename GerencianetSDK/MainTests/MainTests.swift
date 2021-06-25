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
    
    var sut: Gerencianet?
    
    override func setUp() {
        sut = makeSut()
        testAuthentication(sut: sut!)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_environment_variables() {
        let url = Environment.variable(.apiBaseUrl)
        let interval = Environment.variable(.tokenUpdateInterval)
        XCTAssertNotNil(url)
        XCTAssertNotNil(interval)
    }
    
    func test_chargeOneStep_should_completes_with_success() {
        let exp = expectation(description: "waiting")
        sut!.chargeOneStep(chargeOneStepRequest: makeChargeOneStepModel()) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
            case .failure(let error):
                XCTFail("Expect success got \(error) instead")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
}

extension MainTests {
    
    func makeSut() -> Gerencianet {
        return Gerencianet()
    }
    
    func testAuthentication(sut: Gerencianet, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "waiting")
        sut.auth(model: makeAuthenticationModel()) { result in
            switch result {
            case .success:
                XCTAssertNotNil(sut.token, file: file, line: line)
            case .failure(let error):
                XCTFail("Expect success got \(error) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
    
    func makeAuthenticationModel() -> AuthenticationModel {
        return AuthenticationModel(clientId: "Client_Id_e89b59870bcfc8285adc603662fafb60e403ccb1",
                                   clientSecret: "Client_Secret_35f3fbcd52bfb705701e5cf769501d8b8c32f0a8")
    }
}
