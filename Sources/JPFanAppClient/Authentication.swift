//
//  Authentication.swift
//  JPFanAppClient
//
//  Created by Christoph Pageler on 17.08.18.
//


import Foundation
import Quack


public extension JPFanAppClient {

    // MARK: - Login

    public class LoginResult: Quack.Model {

        public let token: String
        public let userID: Int

        public required init?(json: JSON) {
            guard let token = json["string"].string,
                let userID = json["userID"].int
            else {
                return nil
            }

            self.token = token
            self.userID = userID
        }

    }

    public func authLogin(email: String, password: String) -> Quack.Result<LoginResult> {
        let body = Quack.JSONBody([
            "email" : email,
            "password": password
        ])
        return respond(method: .post,
                       path: "/api/v1/auth/login",
                       body: body,
                       headers: defaultHeader,
                       model: LoginResult.self,
                       requestModification: jsonEncodingModification)
    }

    public func authLogin(email: String,
                          password: String,
                          completion: @escaping (Quack.Result<LoginResult>) -> Void) {
        let body = Quack.JSONBody([
            "email" : email,
            "password": password
        ])
        respondAsync(method: .post,
                     path: "/api/v1/auth/login",
                     body: body,
                     headers: defaultHeader,
                     model: LoginResult.self,
                     requestModification: jsonEncodingModification,
                     completion: completion)
    }

    // MARK: - Change Password

    public func authChangePassword(password: String) -> Quack.Void {
        let body = Quack.JSONBody([
            "password": password
        ])
        return respondVoid(method: .post,
                           path: "/api/v1/auth/changePassword",
                           body: body,
                           headers: defaultAuthorizedHeader,
                           requestModification: jsonEncodingModification)
    }

    public func authChangePassword(password: String,
                                   completion: @escaping (Quack.Void) -> Void) {
        let body = Quack.JSONBody([
            "password": password
        ])
        respondVoidAsync(method: .post,
                         path: "/api/v1/auth/changePassword",
                         body: body,
                         headers: defaultAuthorizedHeader,
                         requestModification: jsonEncodingModification,
                         completion: completion)
    }

}
