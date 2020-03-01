//
//  VideoSerie.swift
//  JPFanAppClient
//
//  Created by Christoph Pageler on 25.10.18.
//


import Foundation
import AsyncHTTPClient
import NIO


public extension JPFanAppClient {

    struct VideoSerie: Codable {

        public let id: Int?
        public var title: String
        public var description: String
        public var isPublic: Bool
        public let isDraft: Bool
        public let createdAt: Date?
        public let updatedAt: Date?

        public init(title: String,
                    description: String,
                    isPublic: Bool) {
            self.id = nil
            self.title = title
            self.description = description
            self.isPublic = isPublic
            self.isDraft = false
            self.createdAt = nil
            self.updatedAt = nil
        }

    }

    struct VideoSerieYoutubeVideo: Codable {

        public let video: YoutubeVideo
        public let description: String?

    }


    struct VideoSerieYoutubeVideoRelation: Codable {

        public let id: Int?

        public var videoSerieID: Int
        public var youtubeVideoID: Int

        public var description: String?

        public let createdAt: Date?
        public let updatedAt: Date?

    }

    // MARK: - Index

    func videoSeriesIndex() -> EventLoopFuture<[VideoSerie]> {
        return get("/api/v1/videoSeries")
    }

    func videoSeriesIndexDraft() -> EventLoopFuture<[VideoSerie]> {
        return get("/api/v1/videoSeries/draft", headers: defaultAuthorizedHeader)
    }

    // MARK: - Show

    func videoSeriesShow(id: Int) -> EventLoopFuture<VideoSerie> {
        return get("/api/v1/videoSeries/\(id)")
    }

    // MARK: - Create

    func videoSeriesCreate(videoSerie: VideoSerie) -> EventLoopFuture<VideoSerie> {
        return post("/api/v1/videoSeries", headers: defaultAuthorizedHeader, body: videoSerie)
    }

    // MARK: - Patch

    func videoSeriesPatch(id: Int, videoSerie: VideoSerie) -> EventLoopFuture<VideoSerie> {
        return patch("/api/v1/videoSeries/\(id)", headers: defaultAuthorizedHeader, body: videoSerie)
    }

    // MARK: - Publish

    func videoSeriesPublish(id: Int) -> EventLoopFuture<VideoSerie> {
        return post("/api/v1/videoSeries/\(id)/publish", headers: defaultAuthorizedHeader)
    }

    // MARK: - Delete

    func videoSeriesDelete(id: Int) -> EventLoopFuture<Void> {
        return delete("/api/v1/videoSeries/\(id)", headers: defaultAuthorizedHeader)
    }

    // MARK: - Videos

    func videoSeriesVideos(id: Int) -> EventLoopFuture<[VideoSerieYoutubeVideo]> {
        return get("/api/v1/videoSeries/\(id)/videos")
    }

    func videoSeriesVideosDraft(id: Int) -> EventLoopFuture<[VideoSerieYoutubeVideo]> {
        return get("/api/v1/videoSeries/\(id)/videos/draft", headers: defaultAuthorizedHeader)
    }

    // MARK: - Add Relation

    func videoSeriesVideosAdd(id: Int, videoID: Int) -> EventLoopFuture<Void> {
        return post("/api/v1/videoSeries/\(id)/videos/\(videoID)", headers: defaultAuthorizedHeader)
    }

    // MARK: - Remove Relation

    func videoSeriesVideosRemove(id: Int, videoID: Int) -> EventLoopFuture<Void> {
        return delete("/api/v1/videoSeries/\(id)/videos/\(videoID)", headers: defaultAuthorizedHeader)
    }

    // MARK: - Publish Relation

    func videoSeriesVideosPublish(id: Int, videoID: Int) -> EventLoopFuture<Void> {
        return post("/api/v1/videoSeries/\(id)/videos/\(videoID)/publish", headers: defaultAuthorizedHeader)
    }

    // MARK: - Patch Relation

//    func videoSeriesVideosPatch(id: Int,
//                                videoID: Int,
//                                description: String) -> EventLoopFuture<VideoSerieYoutubeVideoRelation> {
//        return respond(method: .patch,
//                       path: "/api/v1/videoSeries/\(id)/videos/\(videoID)",
//                       body: Quack.JSONBody(["description" : description]),
//                       headers: defaultAuthorizedHeader,
//                       model: VideoSerieYoutubeVideoRelation.self,
//                       requestModification: jsonEncodingModification)
//    }

    // MARK: - VideoSeries Videos Relations

    func videoSeriesVideosRelations() -> EventLoopFuture<[VideoSerieYoutubeVideoRelation]> {
        return get("/api/v1/videoSeriesVideosRelations")
    }

}
