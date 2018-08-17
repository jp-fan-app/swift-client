//
//  CarImageTests.swift
//  JPFanAppClientTests
//
//  Created by Christoph Pageler on 17.08.18.
//


import XCTest
import AppKit
@testable import JPFanAppClient


class CarImageTests: XCTestCase {

    static var allTests = [
        ("testImageUpload", testImageUpload),
        ("testImageUploadAsync", testImageUploadAsync),
        ("testImageFile", testImageFile)
    ]

    func testImageUpload() {
        let client = JPFanAppClient(url: TestData.url)
        client.authToken = TestData.authToken
        
        let imageData = try! Data(contentsOf: TestData.sampleImageFileURL)
        let image = NSImage(data: imageData)
        XCTAssertNotNil(image)

        let result = client.imagesUpload(id: 6, imageData: imageData)
        switch result {
        case .success:
            break
        case .failure:
            XCTFail()
        }
    }

    func testImageUploadAsync() {
        let exp = expectation(description: "expectation")

        let client = JPFanAppClient(url: TestData.url)
        client.authToken = TestData.authToken

        let imageData = try! Data(contentsOf: TestData.sampleImageFileURL)
        let image = NSImage(data: imageData)
        XCTAssertNotNil(image)

        client.imagesUpload(id: 6, imageData: imageData) { result in
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

    func testImageFile() {
        let client = JPFanAppClient(url: TestData.url)
        let result = client.imagesFile(id: 6)
        switch result {
        case .success(let file):
            guard let data = file.data else {
                XCTFail()
                return
            }

            let image = NSImage(data: data)
            XCTAssertNotNil(image)
        case .failure:
            XCTFail()
        }
    }

    func testImageFileAsync() {
        let exp = expectation(description: "expectation")

        let client = JPFanAppClient(url: TestData.url)
        client.imagesFile(id: 6) { result in
            switch result {
            case .success(let file):
                guard let data = file.data else {
                    XCTFail()
                    return
                }

                let image = NSImage(data: data)
                XCTAssertNotNil(image)
            case .failure:
                XCTFail()
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 15, handler: nil)
    }


}
