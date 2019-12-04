//
//  NotificationPreference.swift
//  JPFanAppClient
//
//  Created by Christoph Pageler on 17.08.18.
//


import Foundation
import AsyncHTTPClient
import NIO


public extension JPFanAppClient {

    struct NotificationPreference: Codable {

        public let id: Int?
        public let entityType: String
        public let entityID: String?
        public let createdAt: Date?
        public let updatedAt: Date?

    }

}
