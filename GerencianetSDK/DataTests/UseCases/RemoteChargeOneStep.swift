//
//  DataTests.swift
//  DataTests
//
//  Created by Heitor Novais | Gerencianet on 22/06/21.
//

import XCTest
import Domain
import Data

class RemoteChargeOneStepTests: XCTestCase {
    
    func test_charge_should_call_httpClient_with_correct_url() {
        let url = makeUrl()
        let (sut, httpClientSpy) = makeSut(url: url)
        sut.execute(token: "any_token", model: makeChargeOneStepModel()) { _ in }
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    func test_charge_should_call_httpClient_with_correct_data() {
        let (sut, httpClientSpy) = makeSut()
        sut.execute(token: "any_token", model: makeChargeOneStepModel()) { _ in }
        XCTAssertNotNil(httpClientSpy.body)
    }
    
    func test_charge_should_complete_with_error_if_client_completes_with_error() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.completeWithError(.noConnectivity)
        })
    }
    
    func test_charge_should_complete_with_data_if_client_completes_with_valid_data() {
        let (sut, httpClientSpy) = makeSut()
        let chargeOneStepResponse = makeChargeOneStepResponse()
        expect(sut, completeWith: .success(chargeOneStepResponse), when: {
            httpClientSpy.completeWithData(chargeOneStepResponse.toData()!)
        })
    }
    
    func test_charge_should_complete_with_error_if_client_completes_with_invalid_data() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            let invalidData = makeInvalidData()
            httpClientSpy.completeWithData(invalidData)
        })
    }
}

extension RemoteChargeOneStepTests {
    
    func makeSut(url: URL = URL(string: "http://any-url.com")!, file: StaticString = #file, line: UInt = #line) -> (sut: RemoteChargeOneStep, httpClientSpy: HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteChargeOneStep(endpoint: makeEndpoint(), httpClient: httpClientSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpClientSpy, file: file, line: line)
        return (sut, httpClientSpy)
    }
    
    func expect(_ sut: RemoteChargeOneStep, completeWith expectedResult: ChargeOneStep.Result, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "waiting")
        let chargeOneStepRequest = makeChargeOneStepModel()
        sut.execute(token: "any_token", model: chargeOneStepRequest) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.success(let expectedAccount), .success(let receivedAccount)):
                XCTAssertEqual(expectedAccount, receivedAccount, file: file, line: line)
            case (.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            default:
                XCTFail("Expected \(expectedResult) received \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }
}
