//
//  Notification.swift
//  JPFanAppClient
//
//  Created by Christoph Pageler on 17.08.18.
//


import Foundation
import Quack


public extension JPFanAppClient {

    public class EntityPair {

        public let entityType: String
        public let entityID: String

        public init(entityType: String, entityID: String) {
            self.entityType = entityType
            self.entityID = entityID
        }

    }

    // MARK: - Devices for EntityPair

    public func notificationsDevicesForEntityPair(_ entityPair: EntityPair) -> Quack.Result<[Device]> {
        let params = [
            "entityType": entityPair.entityType,
            "entityID": entityPair.entityID
        ]
        let path = buildPath("/api/v1/notifications/devicesForEntityPair",
                             withParams: params)
        return respondWithArray(method: .get,
                                path: path,
                                headers: defaultAuthorizedHeader,
                                model: Device.self)
    }

    public func notificationsDevicesForEntityPair(_ entityPair: EntityPair,
                                                  completion: @escaping (Quack.Result<[Device]>) -> Void) {
        let params = [
            "entityType": entityPair.entityType,
            "entityID": entityPair.entityID
        ]
        let path = buildPath("/api/v1/notifications/devicesForEntityPair",
                             withParams: params)
        respondWithArrayAsync(method: .get,
                              path: path,
                              headers: defaultAuthorizedHeader,
                              model: Device.self,
                              completion: completion)
    }

    // MARK: - Send Notification for EntityPair

    public func notificationsSendNotificationForEntityPair(_ entityPair: EntityPair) -> Quack.Void {
        let body = Quack.JSONBody([
            "entityType": entityPair.entityType,
            "entityID": entityPair.entityID
        ])
        return respondVoid(method: .post,
                           path: "/api/v1/notifications/sendNotificationForEntityPair",
                           body: body,
                           headers: defaultAuthorizedHeader)
    }

    public func notificationsSendNotificationForEntityPair(_ entityPair: EntityPair,
                                                           completion: @escaping (Quack.Void) -> Void) {
        let body = Quack.JSONBody([
            "entityType": entityPair.entityType,
            "entityID": entityPair.entityID
        ])
        respondVoidAsync(method: .post,
                         path: "/api/v1/notifications/sendNotificationForEntityPair",
                         body: body,
                         headers: defaultAuthorizedHeader,
                         completion: completion)
    }

    // MARK: - Track notification

    public func notificationsTrack(id: String) -> Quack.Void {
        return respondVoid(method: .post,
                           path: "/api/v1/notifications/track/\(id)",
                           headers: defaultHeader)
    }

    public func notificationsTrack(id: String,
                                   completion: @escaping (Quack.Void) -> Void) {
        respondVoidAsync(method: .post,
                         path: "/api/v1/notifications/track/\(id)",
                         headers: defaultHeader,
                         completion: completion)
    }

}
