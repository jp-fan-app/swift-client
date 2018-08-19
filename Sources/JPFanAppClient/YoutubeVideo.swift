//
//  YoutubeVideo.swift
//  JPFanAppClient
//
//  Created by Christoph Pageler on 17.08.18.
//


import Foundation
import Quack


public extension JPFanAppClient {

    public class YoutubeVideo: Quack.Model {

        let id: Int?
        let videoID: Int
        let title: String
        let description: String
        let publishedAt: Date
        let thumbnailURL: String
        let createdAt: Date?
        let updatedAt: Date?

        public required init?(json: JSON) {
            guard let id = json["id"].int,
                let videoID = json["videoID"].int,
                let title = json["title"].string,
                let description = json["description"].string,
                let publishedAtString = json["publishedAt"].string,
                let publishedAt = JPFanAppClient.dateFormatter.date(from: publishedAtString),
                let thumbnailURL = json["thumbnailURL"].string
            else {
                return nil
            }

            self.id = id
            self.videoID = videoID
            self.title = title
            self.description = description
            self.publishedAt = publishedAt
            self.thumbnailURL = thumbnailURL
            self.createdAt = JPFanAppClient.date(from: json["createdAt"].string)
            self.updatedAt = JPFanAppClient.date(from: json["updatedAt"].string)
        }

    }

    // MARK: - Index

    public func videosIndex() -> Quack.Result<[YoutubeVideo]> {
        return respondWithArray(method: .get,
                                path: "/api/v1/videos",
                                headers: defaultHeader,
                                model: YoutubeVideo.self)
    }

    public func videosIndex(completion: @escaping (Quack.Result<[YoutubeVideo]>) -> Void) {
        respondWithArrayAsync(method: .get,
                              path: "/api/v1/videos",
                              headers: defaultHeader,
                              model: YoutubeVideo.self,
                              completion: completion)
    }

    // MARK: - Show

    public func videosShow(id: Int) -> Quack.Result<YoutubeVideo> {
        return respond(method: .get,
                       path: "/api/v1/videos/\(id)",
                       headers: defaultHeader,
                       model: YoutubeVideo.self)
    }

    public func videosShow(id: Int,
                            completion: @escaping (Quack.Result<YoutubeVideo>) -> Void) {
        respondAsync(method: .get,
                     path: "/api/v1/videos/\(id)",
                     headers: defaultHeader,
                     model: YoutubeVideo.self,
                     completion: completion)
    }

    // MARK: - Show by VideoID

    public func videosShow(videoID: String) -> Quack.Result<YoutubeVideo> {
        return respond(method: .get,
                       path: "/api/v1/videos/byVideoID/\(videoID)",
                       headers: defaultHeader,
                       model: YoutubeVideo.self)
    }

    public func videosShow(videoID: String,
                           completion: @escaping (Quack.Result<YoutubeVideo>) -> Void) {
        respondAsync(method: .get,
                     path: "/api/v1/videos/byVideoID/\(videoID)",
                     headers: defaultHeader,
                     model: YoutubeVideo.self,
                     completion: completion)
    }

    // MARK: - Stages

    public func videosStages(id: Int) -> Quack.Result<[CarStage]> {
        return respondWithArray(method: .get,
                                path: "/api/v1/videos/\(id)/stages",
                                headers: defaultHeader,
                                model: CarStage.self)
    }

    public func videosStages(id: Int,
                             completion: @escaping (Quack.Result<[CarStage]>) -> Void) {
        respondWithArrayAsync(method: .get,
                              path: "/api/v1/videos/\(id)/stages",
                              headers: defaultHeader,
                              model: CarStage.self,
                              completion: completion)
    }

}
