//
//  Feature+User.swift
//  JPFanAppClient
//
//  Created by Christoph Pageler on 25.02.20.
//


import Foundation
import AsyncHTTPClient
import NIO


public extension JPFanAppClient {

    struct User: Codable {

        public let id: Int
        public let name: String
        public let email: String
        public let isAdmin: Bool

    }

    struct UserToken: Codable {

        public let id: Int?
        public let string: String
        public let userID: Int
        public let createdAt: Date?
        public let updatedAt: Date?

    }

    struct EditUser: Codable {

        public let name: String
        public let email: String
        public let password: String
        public let isAdmin: Bool

        private init(name: String, email: String, password: String, isAdmin: Bool) {
            self.name = name
            self.email = email
            self.password = password
            self.isAdmin = isAdmin
        }

        public static func forCreate(name: String, email: String, password: String, isAdmin: Bool) -> EditUser {
            return EditUser(name: name, email: email, password: password, isAdmin: isAdmin)
        }

        public static func forPatch(name: String, email: String, isAdmin: Bool) -> EditUser {
            return EditUser(name: name, email: email, password: "", isAdmin: isAdmin)
        }

    }

    // MARK: - Index

    func usersIndex() -> EventLoopFuture<[User]> {
        return get("/api/v1/user")
    }

    // MARK: - Show

    func usersShow(id: Int) -> EventLoopFuture<User> {
        return get("/api/v1/user/\(id)")
    }

    // MARK: - Create

    func usersCreate(user: EditUser) -> EventLoopFuture<User> {
        return post("/api/v1/user", headers: defaultAuthorizedHeader, body: user)
    }

    // MARK: - Patch

    func usersPatch(id: Int, user: EditUser) -> EventLoopFuture<User> {
        return patch("/api/v1/user/\(id)", headers: defaultAuthorizedHeader, body: user)
    }

    // MARK: - Delete

    func usersDelete(id: Int) -> EventLoopFuture<Void> {
        return delete("/api/v1/user/\(id)", headers: defaultAuthorizedHeader)
    }

    // MARK: - Change Password

    func usersChangePassword(id: Int, newPassword: String) -> EventLoopFuture<User> {
        struct ChangePasswordStruct: Codable {
            let password: String
        }
        let body = ChangePasswordStruct(password: newPassword)
        return delete("/api/v1/user/\(id)/changePassword", headers: defaultAuthorizedHeader, body: body)
    }

    // MARK: - Show Tokens

    func usersShowTokens(id: Int) -> EventLoopFuture<[UserToken]> {
        return get("/api/v1/user/\(id)/tokens", headers: defaultAuthorizedHeader)
    }

    // MARK: - Delete Tokens

    func usersDeleteTokens(id: Int) -> EventLoopFuture<Void> {
        return delete("/api/v1/user/\(id)/tokens", headers: defaultAuthorizedHeader)
    }

}
