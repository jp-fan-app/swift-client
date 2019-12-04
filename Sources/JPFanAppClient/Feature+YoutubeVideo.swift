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

    // MARK: - Index

    func videosIndex() -> EventLoopFuture<[YoutubeVideo]> {
        return get("/api/v1/videos")
    }

    // MARK: - Show

    func videosShow(id: Int) -> EventLoopFuture<YoutubeVideo> {
        return get("/api/v1/videos/\(id)")
    }

    // MARK: - Show by VideoID

    func videosShow(videoID: String) -> EventLoopFuture<YoutubeVideo> {
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
