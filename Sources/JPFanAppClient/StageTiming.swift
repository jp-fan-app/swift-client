//
//  StageTiming.swift
//  JPFanAppClient
//
//  Created by Christoph Pageler on 17.08.18.
//


import Foundation
import Quack


public extension JPFanAppClient {

    class StageTiming: Quack.Model {

        public let id: Int?
        public var stageID: Int
        public var range: String
        public var second1: Double?
        public var second2: Double?
        public var second3: Double?
        public let createdAt: Date?
        public let updatedAt: Date?

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
            self.createdAt = JPFanAppClient.date(from: json["createdAt"].string)
            self.updatedAt = JPFanAppClient.date(from: json["updatedAt"].string)
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
            self.createdAt = nil
            self.updatedAt = nil
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

    // MARK: - Index

    func timingsIndex() -> Quack.Result<[StageTiming]> {
        return respondWithArray(method: .get,
                                path: "/api/v1/timings",
                                headers: defaultHeader,
                                model: StageTiming.self)
    }

    func timingsIndex(completion: @escaping (Quack.Result<[StageTiming]>) -> Void) {
        respondWithArrayAsync(method: .get,
                              path: "/api/v1/timings",
                              headers: defaultHeader,
                              model: StageTiming.self,
                              completion: completion)
    }

    // MARK: - Show

    func timingsShow(id: Int) -> Quack.Result<StageTiming> {
        return respond(method: .get,
                       path: "/api/v1/timings/\(id)",
                       headers: defaultHeader,
                       model: StageTiming.self)
    }

    func timingsShow(id: Int, completion: @escaping (Quack.Result<StageTiming>) -> Void) {
        respondAsync(method: .get,
                     path: "/api/v1/timings/\(id)",
                     headers: defaultHeader,
                     model: StageTiming.self,
                     completion: completion)
    }

    // MARK: - Create

    func timingsCreate(timing: StageTiming) -> Quack.Result<StageTiming> {
        return respond(method: .post,
                       path: "/api/v1/timings",
                       body: timing.jsonBody(),
                       headers: defaultAuthorizedHeader,
                       model: StageTiming.self,
                       requestModification: jsonEncodingModification)
    }

    func timingsCreate(timing: StageTiming, completion: @escaping (Quack.Result<StageTiming>) -> Void) {
        respondAsync(method: .post,
                     path: "/api/v1/timings",
                     body: timing.jsonBody(),
                     headers: defaultAuthorizedHeader,
                     model: StageTiming.self,
                     requestModification: jsonEncodingModification,
                     completion: completion)
    }

    // MARK: - Patch

    func timingsPatch(id: Int, timing: StageTiming) -> Quack.Result<StageTiming> {
        return respond(method: .patch,
                       path: "/api/v1/timings/\(id)",
                       body: timing.jsonBody(),
                       headers: defaultAuthorizedHeader,
                       model: StageTiming.self,
                       requestModification: jsonEncodingModification)
    }

    func timingsPatch(id: Int,
                      timing: StageTiming,
                      completion: @escaping (Quack.Result<StageTiming>) -> Void) {
        respondAsync(method: .patch,
                     path: "/api/v1/timings/\(id)",
                     body: timing.jsonBody(),
                     headers: defaultAuthorizedHeader,
                     model: StageTiming.self,
                     requestModification: jsonEncodingModification,
                     completion: completion)
    }

    // MARK: - Delete

    func timingsDelete(id: Int) -> Quack.Void {
        return respondVoid(method: .delete,
                           path: "/api/v1/timings/\(id)",
                           headers: defaultAuthorizedHeader,
                           requestModification: jsonEncodingModification)
    }

    func timingsDelete(id: Int, completion: @escaping (Quack.Void) -> Void) {
        respondVoidAsync(method: .delete,
                         path: "/api/v1/timings/\(id)",
                         headers: defaultAuthorizedHeader,
                         requestModification: jsonEncodingModification,
                         completion: completion)
    }

}
