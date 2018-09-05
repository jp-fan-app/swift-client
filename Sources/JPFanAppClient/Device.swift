//
//  Device.swift
//  JPFanAppClient
//
//  Created by Christoph Pageler on 17.08.18.
//


import Foundation
import Quack


public extension JPFanAppClient {

    public class Device: Quack.Model {

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

        public required init?(json: JSON) {
            guard let id = json["id"].int,
                let isTestDevice = json["isTestDevice"].bool,
                let languageCode = json["languageCode"].string,
                let pushToken = json["pushToken"].string,
                let platformInt = json["platform"].int,
                let platform = Platform(rawValue: platformInt)
            else {
                return nil
            }

            self.id = id
            self.externalID = json["externalID"].string
            self.isTestDevice = isTestDevice
            self.languageCode = languageCode
            self.pushToken = pushToken
            self.platform = platform
            self.createdAt = JPFanAppClient.date(from: json["createdAt"].string)
            self.updatedAt = JPFanAppClient.date(from: json["updatedAt"].string)
        }

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

        internal func jsonBody() -> Quack.JSONBody {
            return Quack.JSONBody([
                "languageCode": languageCode,
                "pushToken": pushToken,
                "platform": platform.rawValue as Any
            ])
        }

    }

    // MARK: - Index

    public func devicesIndex() -> Quack.Result<[Device]> {
        return respondWithArray(method: .get,
                                path: "/api/v1/devices",
                                headers: defaultAuthorizedHeader,
                                model: Device.self)
    }

    public func devicesIndex(completion: @escaping (Quack.Result<[Device]>) -> Void) {
        respondWithArrayAsync(method: .get,
                              path: "/api/v1/devices",
                              headers: defaultAuthorizedHeader,
                              model: Device.self,
                              completion: completion)
    }

    // MARK: - Show

    public func devicesShow(pushToken: String) -> Quack.Result<Device> {
        return respond(method: .get,
                       path: "/api/v1/devices/\(pushToken)",
                       headers: defaultHeader,
                       model: Device.self)
    }

    public func devicesShow(pushToken: String,
                            completion: @escaping (Quack.Result<Device>) -> Void) {
        respondAsync(method: .get,
                     path: "/api/v1/devices/\(pushToken)",
                     headers: defaultHeader,
                     model: Device.self,
                     completion: completion)
    }

    // MARK: - Create

    public func devicesCreate(device: Device) -> Quack.Result<Device> {
        return respond(method: .post,
                       path: "/api/v1/devices",
                       body: device.jsonBody(),
                       headers: defaultHeader,
                       model: Device.self,
                       requestModification: jsonEncodingModification)
    }

    public func devicesCreate(device: Device,
                              completion: @escaping (Quack.Result<Device>) -> Void) {
        respondAsync(method: .post,
                     path: "/api/v1/devices",
                     body: device.jsonBody(),
                     headers: defaultHeader,
                     model: Device.self,
                     requestModification: jsonEncodingModification,
                     completion: completion)
    }

    // MARK: - Patch

    public func devicesPatch(pushToken: String,
                             device: Device) -> Quack.Result<Device> {
        return respond(method: .patch,
                       path: "/api/v1/devices/\(pushToken)",
                       body: device.jsonBody(),
                       headers: defaultHeader,
                       model: Device.self,
                       requestModification: jsonEncodingModification)
    }

    public func devicesPatch(pushToken: String,
                             device: Device,
                             completion: @escaping (Quack.Result<Device>) -> Void) {
        respondAsync(method: .patch,
                     path: "/api/v1/devices/\(pushToken)",
                     body: device.jsonBody(),
                     headers: defaultHeader,
                     model: Device.self,
                     requestModification: jsonEncodingModification,
                     completion: completion)
    }

    // MARK: - Delete

    public func devicesDelete(pushToken: String) -> Quack.Void {
        return respondVoid(method: .delete,
                           path: "/api/v1/devices/\(pushToken)",
                           headers: defaultHeader,
                           requestModification: jsonEncodingModification)
    }

    public func devicesDelete(pushToken: String,
                              completion: @escaping (Quack.Void) -> Void) {
        respondVoidAsync(method: .delete,
                         path: "/api/v1/devices/\(pushToken)",
                         headers: defaultHeader,
                         requestModification: jsonEncodingModification,
                         completion: completion)
    }

    // MARK: - Set Test Device

    public func devicesSetTestDevice(pushToken: String,
                                     isTestDevice: Bool) -> Quack.Result<Device> {
        let body = Quack.JSONBody([
            "bool": isTestDevice
        ])
        return respond(method: .post,
                       path: "/api/v1/devices/\(pushToken)/setTestDevice",
                       body: body,
                       headers: defaultAuthorizedHeader,
                       model: Device.self,
                       requestModification: jsonEncodingModification)
    }

    public func devicesSetTestDevice(pushToken: String,
                                     isTestDevice: Bool,
                                     completion: @escaping (Quack.Result<Device>) -> Void) {
        let body = Quack.JSONBody([
            "bool": isTestDevice
        ])
        respondAsync(method: .post,
                     path: "/api/v1/devices/\(pushToken)/setTestDevice",
                     body: body,
                     headers: defaultAuthorizedHeader,
                     model: Device.self,
                     requestModification: jsonEncodingModification,
                     completion: completion)
    }

    // MARK: - Ping

    public func devicesPing(pushToken: String) -> Quack.Void {
        return respondVoid(method: .post,
                           path: "/api/v1/devices/\(pushToken)/ping",
                           headers: defaultHeader)
    }

    public func devicesPing(pushToken: String,
                            completion: @escaping (Quack.Void) -> Void) {
        respondVoidAsync(method: .post,
                         path: "/api/v1/devices/\(pushToken)/ping",
                         headers: defaultHeader,
                         completion: completion)
    }

    // MARK: - NotificationPreferences

    public func devicesNotificationPreferences(pushToken: String) -> Quack.Result<[NotificationPreference]> {
        return respondWithArray(method: .get,
                                path: "/api/v1/devices/\(pushToken)/notificationPreferences",
                                headers: defaultHeader,
                                model: NotificationPreference.self)
    }

    public func devicesNotificationPreferences(pushToken: String,
                                               completion: @escaping (Quack.Result<[NotificationPreference]>) -> Void) {
        respondWithArrayAsync(method: .get,
                              path: "/api/v1/devices/\(pushToken)/notificationPreferences",
                              headers: defaultHeader,
                              model: NotificationPreference.self,
                              completion: completion)
    }

    // MARK: - Create NotificationPreference

    public func devicesNotificationPreferencesCreate(pushToken: String,
                                                     notificationPreference: NotificationPreference) -> Quack.Result<NotificationPreference> {
        return respond(method: .post,
                       path: "/api/v1/devices/\(pushToken)/notificationPreferences",
                       body: notificationPreference.jsonBody(),
                       headers: defaultHeader,
                       model: NotificationPreference.self,
                       requestModification: jsonEncodingModification)
    }

    public func devicesNotificationPreferencesCreate(pushToken: String,
                                                     notificationPreference: NotificationPreference,
                                                     completion: @escaping (Quack.Result<NotificationPreference>) -> Void) {
        respondAsync(method: .post,
                     path: "/api/v1/devices/\(pushToken)/notificationPreferences",
                     body: notificationPreference.jsonBody(),
                     headers: defaultHeader,
                     model: NotificationPreference.self,
                     requestModification: jsonEncodingModification,
                     completion: completion)
    }

    // MARK: - Delete NotificationPreference

    public func devicesNotificationPreferencesDelete(pushToken: String,
                                                     id: Int) -> Quack.Void {
        return respondVoid(method: .delete,
                           path: "/api/v1/devices/\(pushToken)/notificationPreferences/\(id)",
                           headers: defaultHeader)
    }

    public func devicesNotificationPreferencesDelete(pushToken: String,
                                                     id: Int,
                                                     completion: @escaping (Quack.Void) -> Void) {
        respondVoidAsync(method: .delete,
                         path: "/api/v1/devices/\(pushToken)/notificationPreferences/\(id)",
                         headers: defaultHeader,
                         completion: completion)
    }

}
