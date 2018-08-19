//
//  TestData.swift
//  JPFanAppClientTests
//
//  Created by Christoph Pageler on 17.08.18.
//


import Foundation


public class TestData {

    public static let url = URL(string: "http://localhost:8080")!
    public static var email: String {
        return ProcessInfo.processInfo.environment["email"]!
    }
    public static var password: String {
        return ProcessInfo.processInfo.environment["password"]!
    }
    public static var authToken: String {
        return ProcessInfo.processInfo.environment["authToken"]!
    }
    public static var sampleImageFileURL: URL {
        return URL(fileURLWithPath: ProcessInfo.processInfo.environment["sampleImageFileURL"]!)
    }
    public static var accessToken: String {
        return ProcessInfo.processInfo.environment["accessToken"]!
    }

}
