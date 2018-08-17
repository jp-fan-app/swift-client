//
//  AuthLoginTests.swift
//  JPFanAppClientTests
//
//  Created by Christoph Pageler on 17.08.18.
//


import XCTest
@testable import JPFanAppClient


class AuthenticationTests: XCTestCase {

    static var allTests = [
        ("testValidLogin", testValidLogin),
        ("testValidLoginAsync", testValidLoginAsync),
    ]

    // MARK: - Login

    func testValidLogin() {
        let client = JPFanAppClient(url: TestData.url)
        let result = client.authLogin(email: TestData.email,
                                      password: TestData.password)
        switch result {
        case .success(let result):
            XCTAssertGreaterThan(result.token.count, 1)
        case .failure:
            XCTFail()
        }
    }

    func testValidLoginAsync() {
        let exp = expectation(description: "expectation")

        let client = JPFanAppClient(url: TestData.url)

        client.authLogin(email: TestData.email,
                         password: TestData.password)
        { result in
            switch result {
            case .success(let result):
                XCTAssertGreaterThan(result.token.count, 1)
            case .failure:
                XCTFail()
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 15, handler: nil)
    }

    // MARK: - Change Password

    func testValidChangePassword() {
        let client = JPFanAppClient(url: TestData.url)
        client.authToken = TestData.authToken
        let result = client.authChangePassword(password: TestData.password)
        switch result {
        case .success:
            break
        case .failure:
            XCTFail()
        }
    }

    func testValidChangePasswordAsync() {
        let exp = expectation(description: "expectation")

        let client = JPFanAppClient(url: TestData.url)
        client.authToken = TestData.authToken

        client.authChangePassword(password: TestData.password) { result in
            switch result {
            case .success:
                break
            case .failure:
                XCTFail()
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 15, handler: nil)
    }


}
