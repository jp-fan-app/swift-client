//
//  NotificationPreference.swift
//  JPFanAppClient
//
//  Created by Christoph Pageler on 17.08.18.
//


import Foundation
import Quack


public extension JPFanAppClient {

    public class NotificationPreference: Quack.Model {

        public let id: Int?
        public let entityType: String
        public let entityID: String?
        public let createdAt: Date?
        public let updatedAt: Date?

        public required init?(json: JSON) {
            guard let id = json["id"].int,
                let entityType = json["entityType"].string
            else {
                return nil
            }

            self.id = id
            self.entityType = entityType
            self.entityID = json["entityID"].string
            self.createdAt = JPFanAppClient.date(from: json["createdAt"].string)
            self.updatedAt = JPFanAppClient.date(from: json["updatedAt"].string)
        }

        public init(entityType: String,
                    entityID: String?) {
            self.id = nil
            self.entityType = entityType
            self.entityID = entityID
            self.createdAt = nil
            self.updatedAt = nil
        }

        internal func jsonBody() -> Quack.JSONBody {
            return Quack.JSONBody([
                "entityType": entityType,
                "entityID": entityID as Any
            ])
        }
        
    }

}
