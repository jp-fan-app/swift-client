//
//  StageTiming.swift
//  JPFanAppClient
//
//  Created by Christoph Pageler on 17.08.18.
//


import Foundation
import AsyncHTTPClient
import NIO


public extension JPFanAppClient {

    struct StageTiming: Codable {

        public let id: Int?
        public var stageID: Int
        public var range: String
        public var second1: Double?
        public var second2: Double?
        public var second3: Double?
        public let createdAt: Date?
        public let updatedAt: Date?

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

    }

    // MARK: - Index

    func timingsIndex() -> EventLoopFuture<[StageTiming]> {
        return get("/api/v1/timings")
    }

    func timingsIndexDraft() -> EventLoopFuture<[StageTiming]> {
        return get("/api/v1/timings/draft")
    }

    // MARK: - Show

    func timingsShow(id: Int) -> EventLoopFuture<StageTiming> {
        return get("/api/v1/timings/\(id)")
    }

    // MARK: - Create

    func timingsCreate(timing: StageTiming) -> EventLoopFuture<StageTiming> {
        return post("/api/v1/timings", headers: defaultAuthorizedHeader, body: timing)
    }

    // MARK: - Patch

    func timingsPatch(id: Int, timing: StageTiming) -> EventLoopFuture<StageTiming> {
        return patch("/api/v1/timings/\(id)", headers: defaultAuthorizedHeader, body: timing)
    }

    // MARK: - Publish

    func timingsPublish(id: Int) -> EventLoopFuture<StageTiming> {
        return post("/api/v1/timings/\(id)/publish", headers: defaultAuthorizedHeader)
    }

    // MARK: - Delete

    func timingsDelete(id: Int) -> EventLoopFuture<Void> {
        return delete("/api/v1/timings/\(id)", headers: defaultAuthorizedHeader)
    }

}
