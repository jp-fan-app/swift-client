//
//  Client.swift
//  JPFanAppClient
//
//  Created by Christoph Pageler on 17.08.18.
//


import Foundation
import Quack


public class JPFanAppClient: Quack.Client {

    private let accessToken: String

    public init(accessToken: String,
                url: URL) {
        self.accessToken = accessToken

        self.jsonEncodingModification = { request in
            var request = request
            request.encoding = .json
            return request
        }
        
        super.init(url: url)
    }

    public static func production(accessToken: String) -> JPFanAppClient {
        return JPFanAppClient(accessToken: accessToken,
                              url: URL(string: "http://178.128.203.132:80")!)
    }

    typealias RequestModificationClosure = ((Quack.Request) -> (Quack.Request))

    internal var jsonEncodingModification: RequestModificationClosure

    internal var defaultHeader: [String: String] {
        return [
            "Content-Type": "application/json",
            "x-access-token": accessToken
        ]
    }

    internal var defaultAuthorizedHeader: [String: String] {
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(authToken ?? "")",
            "x-access-token": accessToken
        ]
    }

    public var authToken: String? = nil

    internal static var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return df
    }

    internal static func date(from: String?) -> Date? {
        guard let string = from else { return nil }
        return dateFormatter.date(from: string)
    }

}
