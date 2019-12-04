//
//  Notification.swift
//  JPFanAppClient
//
//  Created by Christoph Pageler on 17.08.18.
//


import Foundation
import AsyncHTTPClient
import NIO


public extension JPFanAppClient {

    struct EntityPair: Codable {

        public let entityType: String
        public let entityID: String

        public init(entityType: String, entityID: String) {
            self.entityType = entityType
            self.entityID = entityID
        }

    }

    // MARK: - Devices for EntityPair

    func notificationsDevicesForEntityPair(_ entityPair: EntityPair) -> EventLoopFuture<[Device]> {
        let params = "entityType=\(entityPair.entityType)&entityID=\(entityPair.entityID)"
        let path = "/api/v1/notifications/devicesForEntityPair?\(params)"
        return get(path, headers: defaultAuthorizedHeader)
    }

    // MARK: - Send Notification for EntityPair

    func notificationsSendNotificationForEntityPair(_ entityPair: EntityPair) -> EventLoopFuture<Void> {
        return post("/api/v1/notifications/sendNotificationForEntityPair",
                    headers: defaultAuthorizedHeader,
                    body: entityPair)
    }

    // MARK: - Track notification

    func notificationsTrack(id: String) -> EventLoopFuture<Void> {
        return post("/api/v1/notifications/track/\(id)", headers: defaultHeader)
    }

}
