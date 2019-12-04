//
//  Device.swift
//  JPFanAppClient
//
//  Created by Christoph Pageler on 17.08.18.
//


import Foundation
import AsyncHTTPClient
import NIO


public extension JPFanAppClient {

    struct Device: Codable {

        public enum Platform: Int, Codable {

            case ios
            case android

        }

        public let id: Int?
        public let externalID: String?
        public let isTestDevice: Bool
        public var languageCode: String
        public var pushToken: String
        public var platform: Platform
        public let createdAt: Date?
        public let updatedAt: Date?

        public init(languageCode: String,
                    pushToken: String,
                    platform: Platform) {
            self.id = nil
            self.externalID = nil
            self.isTestDevice = false
            self.languageCode = languageCode
            self.pushToken = pushToken
            self.platform = platform
            self.createdAt = nil
            self.updatedAt = nil
        }

    }

    // MARK: - Index

    func devicesIndex() -> EventLoopFuture<[Device]> {
        return get("/api/v1/devices")
    }

    // MARK: - Show

    func devicesShow(pushToken: String) -> EventLoopFuture<Device> {
        return get("/api/v1/devices/\(pushToken)")
    }

    // MARK: - Create

    func devicesCreate(device: Device) -> EventLoopFuture<Device> {
        return post("/api/v1/devices", headers: defaultHeader, body: device)
    }

    // MARK: - Patch

    func devicesPatch(pushToken: String, device: Device) -> EventLoopFuture<Device> {
        return patch("/api/v1/devices/\(pushToken)", headers: defaultHeader, body: device)
    }

    // MARK: - Delete

    func devicesDelete(pushToken: String) -> EventLoopFuture<Void> {
        return delete("/api/v1/devices/\(pushToken)", headers: defaultHeader)
    }

    // MARK: - Set Test Device

//    func devicesSetTestDevice(pushToken: String, isTestDevice: Bool) -> EventLoopFuture<Device> {
//        let body = Quack.JSONBody([
//            "bool": isTestDevice
//        ])
//        return respond(method: .post,
//                       path: "/api/v1/devices/\(pushToken)/setTestDevice",
//                       body: body,
//                       headers: defaultAuthorizedHeader,
//                       model: Device.self,
//                       requestModification: jsonEncodingModification)
//    }

    // MARK: - Ping

    func devicesPing(pushToken: String) -> EventLoopFuture<Void> {
        return post("/api/v1/devices/\(pushToken)/ping", headers: defaultHeader)
    }

    // MARK: - NotificationPreferences

    func devicesNotificationPreferences(pushToken: String) -> EventLoopFuture<[NotificationPreference]> {
        return get("/api/v1/devices/\(pushToken)/notificationPreferences")
    }

    // MARK: - Create NotificationPreference

    func devicesNotificationPreferencesCreate(pushToken: String,
                                              notificationPreference: NotificationPreference) -> EventLoopFuture<NotificationPreference> {
        return post("/api/v1/devices/\(pushToken)/notificationPreferences", headers: defaultHeader, body: notificationPreference)
    }

    // MARK: - Delete NotificationPreference

    func devicesNotificationPreferencesDelete(pushToken: String, id: Int) -> EventLoopFuture<Void> {
        return delete("/api/v1/devices/\(pushToken)/notificationPreferences/\(id)", headers: defaultHeader)
    }

}
