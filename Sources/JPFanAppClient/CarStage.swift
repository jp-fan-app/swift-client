//
//  CarStage.swift
//  JPFanAppClient
//
//  Created by Christoph Pageler on 17.08.18.
//


import Foundation
import Quack


public extension JPFanAppClient {

    class CarStage: Quack.Model {

        public let id: Int?
        public var carModelID: Int
        public var name: String
        public var description: String
        public var isStock: Bool
        public var ps: Double?
        public var nm: Double?
        public var lasiseInSeconds: Double?
        public let createdAt: Date?
        public let updatedAt: Date?

        public required init?(json: JSON) {
            guard let id = json["id"].int,
                let carModelID = json["carModelID"].int,
                let name = json["name"].string,
                let isStock = json["isStock"].bool
            else {
                return nil
            }

            self.id = id
            self.carModelID = carModelID
            self.name = name
            self.description = json["description"].string ?? ""
            self.isStock = isStock
            self.ps = json["ps"].double
            self.nm = json["nm"].double
            self.lasiseInSeconds = json["lasiseInSeconds"].double
            self.createdAt = JPFanAppClient.date(from: json["createdAt"].string)
            self.updatedAt = JPFanAppClient.date(from: json["updatedAt"].string)
        }

        public init(carModelID: Int,
                    name: String,
                    description: String,
                    isStock: Bool,
                    ps: Double?,
                    nm: Double?,
                    lasiseInSeconds: Double?) {
            self.id = nil
            self.carModelID = carModelID
            self.name = name
            self.description = description
            self.isStock = isStock
            self.ps = ps
            self.nm = nm
            self.lasiseInSeconds = lasiseInSeconds
            self.createdAt = nil
            self.updatedAt = nil
        }

        internal func jsonBody() -> Quack.JSONBody {
            return Quack.JSONBody([
                "carModelID": carModelID,
                "name": name,
                "description": description,
                "isStock": isStock,
                "ps": ps as Any,
                "nm": nm as Any,
                "lasiseInSeconds": lasiseInSeconds as Any
            ])
        }

    }

    class CarStageYoutubeVideoRelation: Quack.Model {

        public let id: Int?
        public var carStageID: Int
        public var youtubeVideoID: Int
        public let createdAt: Date?
        public let updatedAt: Date?

        public required init?(json: JSON) {
            guard let id = json["id"].int,
                let carStageID = json["carStageID"].int,
                let youtubeVideoID = json["youtubeVideoID"].int
            else {
                return nil
            }

            self.id = id
            self.carStageID = carStageID
            self.youtubeVideoID = youtubeVideoID
            self.createdAt = JPFanAppClient.date(from: json["createdAt"].string)
            self.updatedAt = JPFanAppClient.date(from: json["updatedAt"].string)
        }

    }

    // MARK: - Index

    func stagesIndex() -> Quack.Result<[CarStage]> {
        return respondWithArray(method: .get,
                                path: "/api/v1/stages",
                                headers: defaultHeader,
                                model: CarStage.self)
    }

    func stagesIndex(completion: @escaping (Quack.Result<[CarStage]>) -> Void) {
        respondWithArrayAsync(method: .get,
                              path: "/api/v1/stages",
                              headers: defaultHeader,
                              model: CarStage.self,
                              completion: completion)
    }

    // MARK: - Show

    func stagesShow(id: Int) -> Quack.Result<CarStage> {
        return respond(method: .get,
                       path: "/api/v1/stages/\(id)",
                       headers: defaultHeader,
                       model: CarStage.self)
    }

    func stagesShow(id: Int,
                    completion: @escaping (Quack.Result<CarStage>) -> Void) {
        respondAsync(method: .get,
                     path: "/api/v1/stages/\(id)",
                     headers: defaultHeader,
                     model: CarStage.self,
                     completion: completion)
    }

    // MARK: - Create

    func stagesCreate(stage: CarStage) -> Quack.Result<CarStage> {
        return respond(method: .post,
                       path: "/api/v1/stages",
                       body: stage.jsonBody(),
                       headers: defaultAuthorizedHeader,
                       model: CarStage.self,
                       requestModification: jsonEncodingModification)
    }

    func stagesCreate(stage: CarStage,
                      completion: @escaping (Quack.Result<CarStage>) -> Void) {
        respondAsync(method: .post,
                     path: "/api/v1/stages",
                     body: stage.jsonBody(),
                     headers: defaultAuthorizedHeader,
                     model: CarStage.self,
                     requestModification: jsonEncodingModification,
                     completion: completion)
    }

    // MARK: - Patch

    func stagesPatch(id: Int,
                     stage: CarStage) -> Quack.Result<CarStage> {
        return respond(method: .patch,
                       path: "/api/v1/stages/\(id)",
                       body: stage.jsonBody(),
                       headers: defaultAuthorizedHeader,
                       model: CarStage.self,
                       requestModification: jsonEncodingModification)
    }

    func stagesPatch(id: Int,
                     stage: CarStage,
                     completion: @escaping (Quack.Result<CarStage>) -> Void) {
        respondAsync(method: .patch,
                     path: "/api/v1/stages/\(id)",
                     body: stage.jsonBody(),
                     headers: defaultAuthorizedHeader,
                     model: CarStage.self,
                     requestModification: jsonEncodingModification,
                     completion: completion)
    }

    // MARK: - Delete

    func stagesDelete(id: Int) -> Quack.Void {
        return respondVoid(method: .delete,
                           path: "/api/v1/stages/\(id)",
                           headers: defaultAuthorizedHeader,
                           requestModification: jsonEncodingModification)
    }

    func stagesDelete(id: Int,
                      completion: @escaping (Quack.Void) -> Void) {
        respondVoidAsync(method: .delete,
                         path: "/api/v1/stages/\(id)",
                         headers: defaultAuthorizedHeader,
                         requestModification: jsonEncodingModification,
                         completion: completion)
    }

    // MARK: - Timings

    func stagesTimings(id: Int) -> Quack.Result<[StageTiming]> {
        return respondWithArray(method: .get,
                                path: "/api/v1/stages/\(id)/timings",
                                headers: defaultHeader,
                                model: StageTiming.self)
    }

    func stagesTimings(id: Int,
                       completion: @escaping (Quack.Result<[StageTiming]>) -> Void) {
        respondWithArrayAsync(method: .get,
                              path: "/api/v1/stages/\(id)/timings",
                              headers: defaultHeader,
                              model: StageTiming.self,
                              completion: completion)
    }

    // MARK: - Videos

    func stagesVideos(id: Int) -> Quack.Result<[YoutubeVideo]> {
        return respondWithArray(method: .get,
                                path: "/api/v1/stages/\(id)/videos",
                                headers: defaultHeader,
                                model: YoutubeVideo.self)
    }

    func stagesVideos(id: Int,
                      completion: @escaping (Quack.Result<[YoutubeVideo]>) -> Void) {
        respondWithArrayAsync(method: .get,
                              path: "/api/v1/stages/\(id)/videos",
                              headers: defaultHeader,
                              model: YoutubeVideo.self,
                              completion: completion)
    }

    // MARK: - Add Relation

    func stagesVideosAdd(id: Int, videoID: Int) -> Quack.Void {
        return respondVoid(method: .post,
                           path: "/api/v1/stages/\(id)/videos/\(videoID)",
                           headers: defaultAuthorizedHeader)
    }

    func stagesVideosAdd(id: Int, videoID: Int, completion: @escaping (Quack.Void) -> Void) {
        respondVoidAsync(method: .post,
                         path: "/api/v1/stages/\(id)/videos/\(videoID)",
                         headers: defaultAuthorizedHeader,
                         completion: completion)
    }

    // MARK: - Remove Relation

    func stagesVideosRemove(id: Int, videoID: Int) -> Quack.Void {
        return respondVoid(method: .delete,
                           path: "/api/v1/stages/\(id)/videos/\(videoID)",
                           headers: defaultAuthorizedHeader)
    }

    func stagesVideosRemove(id: Int, videoID: Int, completion: @escaping (Quack.Void) -> Void) {
        respondVoidAsync(method: .delete,
                         path: "/api/v1/stages/\(id)/videos/\(videoID)",
                         headers: defaultAuthorizedHeader,
                         completion: completion)
    }

    // MARK: - Stages Videos Relations

    func stagesVideosRelations() -> Quack.Result<[CarStageYoutubeVideoRelation]> {
        return respondWithArray(method: .get,
                                path: "/api/v1/stagesVideosRelations",
                                headers: defaultHeader,
                                model: CarStageYoutubeVideoRelation.self)
    }

    func stagesVideosRelations(completion: @escaping (Quack.Result<[CarStageYoutubeVideoRelation]>) -> Void) {
        respondWithArrayAsync(method: .get,
                              path: "/api/v1/stagesVideosRelations",
                              headers: defaultHeader,
                              model: CarStageYoutubeVideoRelation.self,
                              completion: completion)
    }

}
