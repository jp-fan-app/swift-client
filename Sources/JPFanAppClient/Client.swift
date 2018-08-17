//
//  Client.swift
//  JPFanAppClient
//
//  Created by Christoph Pageler on 17.08.18.
//


import Foundation
import Quack


public class JPFanAppClient: Quack.Client {

    public init(url: URL) {
        self.jsonEncodingModification = { request in
            var request = request
            request.encoding = .json
            return request
        }
        
        super.init(url: url)
    }

    public static func production() -> JPFanAppClient {
        return JPFanAppClient(url: URL(string: "http://178.128.203.132:80")!)
    }

    typealias RequestModificationClosure = ((Quack.Request) -> (Quack.Request))

    internal var jsonEncodingModification: RequestModificationClosure

    internal var defaultHeader: [String: String] {
        return [
            "Content-Type": "application/json"
        ]
    }

    internal var defaultAuthorizedHeader: [String: String] {
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(authToken ?? "")"
        ]
    }

    public var authToken: String? = nil

}
