//
//  YoutubeVideo.swift
//  JPFanAppClient
//
//  Created by Christoph Pageler on 17.08.18.
//


import Foundation
import AsyncHTTPClient
import NIO


public extension JPFanAppClient {

    struct YoutubeVideo: Codable {

        public let id: Int?
        public let videoID: String
        public let title: String
        public let description: String
        public let publishedAt: Date
        public let thumbnailURL: String
        public let createdAt: Date?
        public let updatedAt: Date?

    }

    struct YoutubeVideoSearchRequest: Codable {

        public let publishedAtNewer: Date?
        public let query: String?

        public init(publishedAtNewer: Date? = nil, query: String? = nil) {
            self.publishedAtNewer = publishedAtNewer
            self.query = query
        }

    }

    // MARK: - Index

    func videosIndex() -> EventLoopFuture<[YoutubeVideo]> {
        return get("/api/v1/videos")
    }

    func videosSearch(_ request: YoutubeVideoSearchRequest) -> EventLoopFuture<[YoutubeVideo]> {
        return post("/api/v1/videos/search", headers: defaultHeader, body: request)
    }

    // MARK: - Show

    func videosShow(id: Int) -> EventLoopFuture<YoutubeVideo> {
        return get("/api/v1/videos/\(id)")
    }

    // MARK: - Show by VideoID

    func videosShow(videoID: String) -> EventLoopFuture<[YoutubeVideo]> {
        return get("/api/v1/videos/byVideoID/\(videoID)")
    }

    // MARK: - Stages

    func videosStages(id: Int) -> EventLoopFuture<[CarStage]> {
        return get("/api/v1/videos/\(id)/stages")
    }

    // MARK: - Video Series

    func videosVideoSeries(id: Int) -> EventLoopFuture<[VideoSerie]> {
        return get("/api/v1/videos/\(id)/videoSeries")
    }

}
