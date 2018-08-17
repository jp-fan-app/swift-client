//
//  StageTiming.swift
//  JPFanAppClient
//
//  Created by Christoph Pageler on 17.08.18.
//


import Foundation
import Quack


public extension JPFanAppClient {

    public class StageTiming: Quack.Model {

        let id: Int?
        var stageID: Int
        var range: String
        let second1: Double?
        let second2: Double?
        let second3: Double?

        public required init?(json: JSON) {
            guard let id = json["id"].int,
                let stageID = json["stageID"].int,
                let range = json["range"].string
            else {
                return nil
            }

            self.id = id
            self.stageID = stageID
            self.range = range
            self.second1 = json["second1"].double
            self.second2 = json["second2"].double
            self.second3 = json["second3"].double
        }

        public init(stageID: Int,
                    range: String,
                    second1: Double?,
                    second2: Double?,
                    second3: Double?) {
            self.id = nil
            self.stageID = stageID
            self.range = range
            self.second1 = second1
            self.second2 = second2
            self.second3 = second3
        }

        internal func jsonBody() -> Quack.JSONBody {
            return Quack.JSONBody([
                "stageID": stageID,
                "range": range,
                "second1": second1 as Any,
                "second2": second2 as Any,
                "second3": second3 as Any
            ])
        }

    }

}
