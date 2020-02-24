//
//  Authentication.swift
//  JPFanAppClient
//
//  Created by Christoph Pageler on 17.08.18.
//


import Foundation
import AsyncHTTPClient
import NIO

public extension JPFanAppClient {

    // MARK: - Login

    struct LoginRequest: Codable {

        public let email: String
        public let password: String

    }

    struct LoginResult: Codable {

        public let token: String
        public let isAdmin: Bool

    }

    func authLogin(email: String, password: String) -> EventLoopFuture<LoginResult> {
        let requestBody = LoginRequest(email: email, password: password)
        return post("/api/v1/auth/login", headers: defaultHeader, body: requestBody)
    }

    // MARK: - Change Password

    struct ChangePasswordRequest: Codable {

        public let password: String

    }

    func authChangePassword(password: String) -> EventLoopFuture<Void> {
        let requestBody = ChangePasswordRequest(password: password)
        return post("/api/v1/auth/changePassword", headers: defaultAuthorizedHeader, body: requestBody)
    }

}
