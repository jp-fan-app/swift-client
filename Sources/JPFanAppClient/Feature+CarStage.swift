//
//  CarStage.swift
//  JPFanAppClient
//
//  Created by Christoph Pageler on 17.08.18.
//


import Foundation
import AsyncHTTPClient
import NIO


public extension JPFanAppClient {

    struct CarStage: Codable {

        public let id: Int?
        public var carModelID: Int
        public var name: String
        public var description: String?
        public var isStock: Bool
        public var ps: Double?
        public var nm: Double?
        public var lasiseInSeconds: Double?
        public let isDraft: Bool
        public let createdAt: Date?
        public let updatedAt: Date?

        public init(carModelID: Int, name: String, description: String?, isStock: Bool,
                    ps: Double?, nm: Double?, lasiseInSeconds: Double?) {
            self.id = nil
            self.carModelID = carModelID
            self.name = name
            self.description = description
            self.isStock = isStock
            self.ps = ps
            self.nm = nm
            self.lasiseInSeconds = lasiseInSeconds
            self.isDraft = false
            self.createdAt = nil
            self.updatedAt = nil
        }

    }

    struct CarStageYoutubeVideoRelation: Codable {

        public let id: Int?
        public var carStageID: Int
        public var youtubeVideoID: Int
        public let createdAt: Date?
        public let updatedAt: Date?

    }

    // MARK: - Index

    func stagesIndex() -> EventLoopFuture<[CarStage]> {
        return get("/api/v1/stages")
    }

    func stagesIndexDraft() -> EventLoopFuture<[CarStage]> {
        return get("/api/v1/stages/draft", headers: defaultAuthorizedHeader)
    }

    // MARK: - Show

    func stagesShow(id: Int) -> EventLoopFuture<CarStage> {
        return get("/api/v1/stages/\(id)")
    }

    // MARK: - Create

    func stagesCreate(stage: CarStage) -> EventLoopFuture<CarStage> {
        return post("/api/v1/stages", headers: defaultAuthorizedHeader, body: stage)
    }

    // MARK: - Patch

    func stagesPatch(id: Int, stage: CarStage) -> EventLoopFuture<CarStage> {
        return patch("/api/v1/stages/\(id)", headers: defaultAuthorizedHeader, body: stage)
    }

    // MARK: - Publish

    func stagesPublish(id: Int) -> EventLoopFuture<CarStage> {
        return post("/api/v1/stages/\(id)/publish", headers: defaultAuthorizedHeader)
    }

    // MARK: - Delete

    func stagesDelete(id: Int) -> EventLoopFuture<Void> {
        return delete("/api/v1/stages/\(id)", headers: defaultAuthorizedHeader)
    }

    // MARK: - Timings

    func stagesTimings(id: Int) -> EventLoopFuture<[StageTiming]> {
        return get("/api/v1/stages/\(id)/timings")
    }

    func stagesTimingsDraft(id: Int) -> EventLoopFuture<[StageTiming]> {
        return get("/api/v1/stages/\(id)/timings/draft", headers: defaultAuthorizedHeader)
    }

    // MARK: - Videos

    func stagesVideos(id: Int) -> EventLoopFuture<[YoutubeVideo]> {
        return get("/api/v1/stages/\(id)/videos")
    }

    func stagesVideosDraft(id: Int) -> EventLoopFuture<[YoutubeVideo]> {
        return get("/api/v1/stages/\(id)/videos/draft", headers: defaultAuthorizedHeader)
    }

    // MARK: - Add Relation

    func stagesVideosAdd(id: Int, videoID: Int) -> EventLoopFuture<Void> {
        return post("/api/v1/stages/\(id)/videos/\(videoID)", headers: defaultAuthorizedHeader)
    }

    // MARK: - Remove Relation

    func stagesVideosRemove(id: Int, videoID: Int) -> EventLoopFuture<Void> {
        return delete("/api/v1/stages/\(id)/videos/\(videoID)", headers: defaultAuthorizedHeader)
    }

    // MARK: - Publish Relation

    func stagesVideosPublish(id: Int, videoID: Int) -> EventLoopFuture<Void> {
        return post("/api/v1/stages/\(id)/videos/\(videoID)/publish", headers: defaultAuthorizedHeader)
    }

    // MARK: - Stages Videos Relations

    func stagesVideosRelations() -> EventLoopFuture<[CarStageYoutubeVideoRelation]> {
        return get("/api/v1/stagesVideosRelations")
    }

}
