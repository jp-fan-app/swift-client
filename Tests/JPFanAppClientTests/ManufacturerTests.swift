//
//  ManufacturerTests.swift
//  JPFanAppClientTests
//
//  Created by Christoph Pageler on 17.08.18.
//


import XCTest
@testable import JPFanAppClient


class ManufacturerTests: XCTestCase {

    static var allTests = [
        ("testIndex", testIndex),
        ("testIndexAsync", testIndexAsync),
        ("testShow", testShow),
        ("testShowAsync", testShowAsync),
        ("testCreate", testCreate),
        ("testCreateAsync", testCreateAsync),
        ("testPatch", testPatch),
        ("testPatchAsync", testPatchAsync),
        ("testModels,", testModels),
        ("testModelsAsync", testModelsAsync)
    ]

    // MARK: - Index

    func testIndex() {
        let client = JPFanAppClient(url: TestData.url)
        let result = client.manufacturersIndex()
        switch result {
        case .success(let manufacturers):
            XCTAssertGreaterThan(manufacturers.count, 0)
        case .failure:
            XCTFail()
        }
    }

    func testIndexAsync() {
        let exp = expectation(description: "expectation")
        let client = JPFanAppClient(url: TestData.url)

        client.manufacturersIndex() { result in
            switch result {
            case .success(let manufacturers):
                XCTAssertGreaterThan(manufacturers.count, 0)
            case .failure:
                XCTFail()
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 15, handler: nil)
    }

    // MARK: - Show

    func testShow() {
        let client = JPFanAppClient(url: TestData.url)
        let result = client.manufacturersShow(id: 21)
        switch result {
        case .success(let manufacturer):
            XCTAssertEqual(manufacturer.id, 21)
            XCTAssertGreaterThan(manufacturer.name.count, 2)
        case .failure:
            XCTFail()
        }
    }

    func testShowAsync() {
        let exp = expectation(description: "expectation")
        let client = JPFanAppClient(url: TestData.url)

        client.manufacturersShow(id: 21) { result in
            switch result {
            case .success(let manufacturer):
                XCTAssertEqual(manufacturer.id, 21)
                XCTAssertGreaterThan(manufacturer.name.count, 2)
            case .failure:
                XCTFail()
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 15, handler: nil)
    }

    // MARK: - Create

    func testCreate() {
        let client = JPFanAppClient(url: TestData.url)
        client.authToken = TestData.authToken
        let newModel = JPFanAppClient.ManufacturerModel(name: "Audi")
        let result = client.manufacturersCreate(manufacturer: newModel)
        switch result {
        case .success(let manufacturer):
            XCTAssertEqual(manufacturer.name, "Audi")
        case .failure:
            XCTFail()
        }
    }

    func testCreateAsync() {
        let exp = expectation(description: "expectation")

        let client = JPFanAppClient(url: TestData.url)
        client.authToken = TestData.authToken
        let newModel = JPFanAppClient.ManufacturerModel(name: "Audi")
        client.manufacturersCreate(manufacturer: newModel)
        { result in
            switch result {
            case .success(let manufacturer):
                XCTAssertEqual(manufacturer.name, "Audi")
            case .failure:
                XCTFail()
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 15, handler: nil)
    }

    // MARK: - Patch

    func testPatch() {
        let client = JPFanAppClient(url: TestData.url)
        client.authToken = TestData.authToken
        let newModel = JPFanAppClient.ManufacturerModel(name: "Audi")
        let result = client.manufacturersPatch(id: 21,
                                               manufacturer: newModel)
        switch result {
        case .success(let manufacturer):
            XCTAssertEqual(manufacturer.id, 21)
            XCTAssertEqual(manufacturer.name, "Audi")
        case .failure:
            XCTFail()
        }
    }

    func testPatchAsync() {
        let exp = expectation(description: "expectation")

        let client = JPFanAppClient(url: TestData.url)
        client.authToken = TestData.authToken
        let newModel = JPFanAppClient.ManufacturerModel(name: "Audi")
        client.manufacturersPatch(id: 21,
                                  manufacturer: newModel)
        { result in
            switch result {
            case .success(let manufacturer):
                XCTAssertEqual(manufacturer.id, 21)
                XCTAssertEqual(manufacturer.name, "Audi")
            case .failure:
                XCTFail()
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 15, handler: nil)
    }

    // MARK: - Delete

    func testDelete() {
        let client = JPFanAppClient(url: TestData.url)
        client.authToken = TestData.authToken
        let result = client.manufacturersDelete(id: 23)
        switch result {
        case .success:
            break
        case .failure:
            XCTFail()
        }
    }

    func testDeleteAsync() {
        let exp = expectation(description: "expectation")

        let client = JPFanAppClient(url: TestData.url)
        client.authToken = TestData.authToken
        client.manufacturersDelete(id: 24)
        { result in
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

    // MARK: - Models

    func testModels() {
        let client = JPFanAppClient(url: TestData.url)
        let result = client.manufacturersModels(id: 21)
        switch result {
        case .success(let models):
            XCTAssertGreaterThanOrEqual(models.count, 1)
        case .failure:
            XCTFail()
        }
    }

    func testModelsAsync() {
        let exp = expectation(description: "expectation")
        let client = JPFanAppClient(url: TestData.url)

        client.manufacturersModels(id: 21) { result in
            switch result {
            case .success(let models):
                XCTAssertGreaterThanOrEqual(models.count, 1)
            case .failure:
                XCTFail()
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 15, handler: nil)
    }

}
