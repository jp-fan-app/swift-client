//
//  VideoSerie.swift
//  JPFanAppClient
//
//  Created by Christoph Pageler on 25.10.18.
//


import Foundation
import Quack


public extension JPFanAppClient {

    class VideoSerie: Quack.Model {

        public let id: Int?
        public var title: String
        public var description: String
        public var isPublic: Bool
        public let createdAt: Date?
        public let updatedAt: Date?

        public required init?(json: JSON) {
            guard let id = json["id"].int,
                let title = json["title"].string,
                let description = json["description"].string,
                let isPublic = json["isPublic"].bool
            else {
                return nil
            }

            self.id = id
            self.title = title
            self.description = description
            self.isPublic = isPublic
            self.createdAt = JPFanAppClient.date(from: json["createdAt"].string)
            self.updatedAt = JPFanAppClient.date(from: json["updatedAt"].string)
        }

        public init(title: String,
                    description: String,
                    isPublic: Bool) {
            self.id = nil
            self.title = title
            self.description = description
            self.isPublic = isPublic
            self.createdAt = nil
            self.updatedAt = nil
        }

        internal func jsonBody() -> Quack.JSONBody {
            return Quack.JSONBody([
                "title": title,
                "description": description,
                "isPublic": isPublic
            ])
        }

    }

    class VideoSerieYoutubeVideo: Quack.Model {

        public let video: YoutubeVideo
        public let description: String?

        public required init?(json: JSON) {
            guard let video = YoutubeVideo(json: json["video"]) else { return nil }

            self.video = video
            self.description = json["description"].string
        }

    }


    class VideoSerieYoutubeVideoRelation: Quack.Model {

        public let id: Int?

        public var videoSerieID: Int
        public var youtubeVideoID: Int

        public var description: String?

        public let createdAt: Date?
        public let updatedAt: Date?

        public required init?(json: JSON) {
            guard let id = json["id"].int,
                let videoSerieID = json["videoSerieID"].int,
                let youtubeVideoID = json["youtubeVideoID"].int
            else {
                return nil
            }

            self.id = id

            self.videoSerieID = videoSerieID
            self.youtubeVideoID = youtubeVideoID

            self.description = json["description"].string

            self.createdAt = JPFanAppClient.date(from: json["createdAt"].string)
            self.updatedAt = JPFanAppClient.date(from: json["updatedAt"].string)
        }

    }

    // MARK: - Index

    func videoSeriesIndex() -> Quack.Result<[VideoSerie]> {
        return respondWithArray(method: .get,
                                path: "/api/v1/videoSeries",
                                headers: defaultHeader,
                                model: VideoSerie.self)
    }

    func videoSeriesIndex(completion: @escaping (Quack.Result<[VideoSerie]>) -> Void) {
        respondWithArrayAsync(method: .get,
                              path: "/api/v1/videoSeries",
                              headers: defaultHeader,
                              model: VideoSerie.self,
                              completion: completion)
    }

    // MARK: - Show

    func videoSeriesShow(id: Int) -> Quack.Result<VideoSerie> {
        return respond(method: .get,
                       path: "/api/v1/videoSeries/\(id)",
                       headers: defaultHeader,
                       model: VideoSerie.self)
    }

    func videoSeriesShow(id: Int, completion: @escaping (Quack.Result<VideoSerie>) -> Void) {
        respondAsync(method: .get,
                     path: "/api/v1/videoSeries/\(id)",
                     headers: defaultHeader,
                     model: VideoSerie.self,
                     completion: completion)
    }

    // MARK: - Create

    func videoSeriesCreate(videoSerie: VideoSerie) -> Quack.Result<VideoSerie> {
        return respond(method: .post,
                       path: "/api/v1/videoSeries",
                       body: videoSerie.jsonBody(),
                       headers: defaultAuthorizedHeader,
                       model: VideoSerie.self,
                       requestModification: jsonEncodingModification)
    }

    func videoSeriesCreate(videoSerie: VideoSerie,
                                  completion: @escaping (Quack.Result<VideoSerie>) -> Void) {
        respondAsync(method: .post,
                     path: "/api/v1/videoSeries",
                     body: videoSerie.jsonBody(),
                     headers: defaultAuthorizedHeader,
                     model: VideoSerie.self,
                     requestModification: jsonEncodingModification,
                     completion: completion)
    }

    // MARK: - Patch

    func videoSeriesPatch(id: Int, videoSerie: VideoSerie) -> Quack.Result<VideoSerie> {
        return respond(method: .patch,
                       path: "/api/v1/videoSeries/\(id)",
                       body: videoSerie.jsonBody(),
                       headers: defaultAuthorizedHeader,
                       model: VideoSerie.self,
                       requestModification: jsonEncodingModification)
    }

    func videoSeriesPatch(id: Int,
                          videoSerie: VideoSerie,
                          completion: @escaping (Quack.Result<VideoSerie>) -> Void) {
        respondAsync(method: .patch,
                     path: "/api/v1/videoSeries/\(id)",
                     body: videoSerie.jsonBody(),
                     headers: defaultAuthorizedHeader,
                     model: VideoSerie.self,
                     requestModification: jsonEncodingModification,
                     completion: completion)
    }

    // MARK: - Delete

    func videoSeriesDelete(id: Int) -> Quack.Void {
        return respondVoid(method: .delete,
                           path: "/api/v1/videoSeries/\(id)",
                           headers: defaultAuthorizedHeader,
                           requestModification: jsonEncodingModification)
    }

    func videoSeriesDelete(id: Int, completion: @escaping (Quack.Void) -> Void) {
        respondVoidAsync(method: .delete,
                         path: "/api/v1/videoSeries/\(id)",
                         headers: defaultAuthorizedHeader,
                         requestModification: jsonEncodingModification,
                         completion: completion)
    }

    // MARK: - Videos

    func videoSeriesVideos(id: Int) -> Quack.Result<[VideoSerieYoutubeVideo]> {
        return respondWithArray(method: .get,
                                path: "/api/v1/videoSeries/\(id)/videos",
                                headers: defaultHeader,
                                model: VideoSerieYoutubeVideo.self)
    }

    func videoSeriesVideos(id: Int, completion: @escaping (Quack.Result<[VideoSerieYoutubeVideo]>) -> Void) {
        respondWithArrayAsync(method: .get,
                              path: "/api/v1/videoSeries/\(id)/videos",
                              headers: defaultHeader,
                              model: VideoSerieYoutubeVideo.self,
                              completion: completion)
    }

    // MARK: - Add Relation

    func videoSeriesVideosAdd(id: Int, videoID: Int) -> Quack.Void {
        return respondVoid(method: .post,
                           path: "/api/v1/videoSeries/\(id)/videos/\(videoID)",
                           headers: defaultAuthorizedHeader)
    }

    func videoSeriesVideosAdd(id: Int, videoID: Int, completion: @escaping (Quack.Void) -> Void) {
        respondVoidAsync(method: .post,
                         path: "/api/v1/videoSeries/\(id)/videos/\(videoID)",
                         headers: defaultAuthorizedHeader,
                         completion: completion)
    }

    // MARK: - Remove Relation

    func videoSeriesVideosRemove(id: Int, videoID: Int) -> Quack.Void {
        return respondVoid(method: .delete,
                           path: "/api/v1/videoSeries/\(id)/videos/\(videoID)",
                           headers: defaultAuthorizedHeader)
    }

    func videoSeriesVideosRemove(id: Int, videoID: Int, completion: @escaping (Quack.Void) -> Void) {
        respondVoidAsync(method: .delete,
                         path: "/api/v1/videoSeries/\(id)/videos/\(videoID)",
                         headers: defaultAuthorizedHeader,
                         completion: completion)
    }

    // MARK: - Patch Relation

    func videoSeriesVideosPatch(id: Int,
                                videoID: Int,
                                description: String) -> Quack.Result<VideoSerieYoutubeVideoRelation> {
        return respond(method: .patch,
                       path: "/api/v1/videoSeries/\(id)/videos/\(videoID)",
                       body: Quack.JSONBody(["description" : description]),
                       headers: defaultAuthorizedHeader,
                       model: VideoSerieYoutubeVideoRelation.self,
                       requestModification: jsonEncodingModification)
    }

    func videoSeriesVideosPatch(id: Int,
                                videoID: Int,
                                description: String,
                                completion: @escaping (Quack.Result<VideoSerieYoutubeVideoRelation>) -> Void) {
        respondAsync(method: .patch,
                     path: "/api/v1/videoSeries/\(id)/videos/\(videoID)",
                     body: Quack.JSONBody(["description" : description]),
                     headers: defaultAuthorizedHeader,
                     model: VideoSerieYoutubeVideoRelation.self,
                     requestModification: jsonEncodingModification,
                     completion: completion)
    }

    // MARK: - VideoSeries Videos Relations

    func videoSeriesVideosRelations() -> Quack.Result<[VideoSerieYoutubeVideoRelation]> {
        return respondWithArray(method: .get,
                                path: "/api/v1/videoSeriesVideosRelations",
                                headers: defaultHeader,
                                model: VideoSerieYoutubeVideoRelation.self)
    }

    func videoSeriesVideosRelations(completion: @escaping (Quack.Result<[VideoSerieYoutubeVideoRelation]>) -> Void) {
        respondWithArrayAsync(method: .get,
                              path: "/api/v1/videoSeriesVideosRelations",
                              headers: defaultHeader,
                              model: VideoSerieYoutubeVideoRelation.self,
                              completion: completion)
    }

}
