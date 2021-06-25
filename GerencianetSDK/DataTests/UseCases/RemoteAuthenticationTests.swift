//
//  RemoteAuthenticationTests.swift
//  DataTests
//
//  Created by Heitor Novais | Gerencianet on 22/06/21.
//

import XCTest
import Domain
import Data

class RemoteAuthenticationTests: XCTestCase {
    
    func test_auth_should_call_httpClient_with_correct_url_and_httpMethod() {
        let endpoint = makeEndpoint()
        let (sut, httpClientSpy) = makeSut(endpoint: endpoint)
        sut.execute(model: makeAuthenticationModel()) { _ in }
        XCTAssertEqual(httpClientSpy.urls, [endpoint.url])
        XCTAssertEqual(httpClientSpy.method, endpoint.method)
    }
    
    func test_auth_should_call_httpClient_with_correct_data() {
        let (sut, httpClientSpy) = makeSut()
        let authenticatioModel = makeAuthenticationModel()
        sut.execute(model: authenticatioModel) { _ in }
        XCTAssertNotNil(httpClientSpy.body)
    }
    
    func test_auth_should_complete_with_error_if_client_completes_with_error() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.completeWithError(.noConnectivity)
        })
    }
    
    func test_auth_should_complete_with_expired_session_in_use_error_if_client_completes_with_unauthorized() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.expiredSession), when: {
            httpClientSpy.completeWithError(.unauthorized)
        })
    }
    
    func test_auth_should_complete_with_error_if_client_completes_with_valid_data() {
        let (sut, httpClientSpy) = makeSut()
        let authenticationResponse = makeAuthenticationResponse()
        expect(sut, completeWith: .success(authenticationResponse), when: {
            httpClientSpy.completeWithData(authenticationResponse.toData()!)
        })
    }
    
    func test_auth_should_complete_with_error_if_client_completes_with_invalid_data() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            let invalidData = makeInvalidData()
            httpClientSpy.completeWithData(invalidData)
        })
    }
}

extension RemoteAuthenticationTests {
    
    func makeSut(endpoint: Endpoint = makeEndpoint(), file: StaticString = #file, line: UInt = #line) -> (sut: RemoteAuthentication, httpClientSpy: HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAuthentication(endpoint: endpoint, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpClientSpy, file: file, line: line)
        return (sut, httpClientSpy)
    }
    
    func expect(_ sut: RemoteAuthentication, completeWith expectedResult: Authentication.Result, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "waiting")
        sut.execute(model: makeAuthenticationModel()) { receivedResult in
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
