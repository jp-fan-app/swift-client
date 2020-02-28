//
//  CarModel.swift
//  JPFanAppClient
//
//  Created by Christoph Pageler on 17.08.18.
//


import Foundation
import AsyncHTTPClient
import NIO


public extension JPFanAppClient {

    struct CarModel: Codable {

        public enum TransmissionType: Int, Codable {

            case manual
            case automatic

        }

        public enum AxleType: Int, Codable {

            case all
            case front
            case rear

        }

        public let id: Int?
        public var name: String
        public var manufacturerID: Int
        public var transmissionType: TransmissionType
        public var axleType: AxleType
        public var mainImageID: Int?
        public let createdAt: Date?
        public let updatedAt: Date?

        public init(name: String,
                    manufacturerID: Int,
                    transmissionType: TransmissionType,
                    axleType: AxleType,
                    mainImageID: Int?) {
            self.id = nil
            self.name = name
            self.manufacturerID = manufacturerID
            self.transmissionType = transmissionType
            self.axleType = axleType
            self.mainImageID = mainImageID
            self.createdAt = nil
            self.updatedAt = nil
        }

    }

    // MARK: - Index

    func modelsIndex() -> EventLoopFuture<[CarModel]> {
        return get("/api/v1/models")
    }

    func modelsIndexDraft() -> EventLoopFuture<[CarModel]> {
        return get("/api/v1/models/draft")
    }

    // MARK: - Show

    func modelsShow(id: Int) -> EventLoopFuture<CarModel> {
        return get("/api/v1/models/\(id)")
    }

    // MARK: - Create

    func modelsCreate(model: CarModel) -> EventLoopFuture<CarModel> {
        return post("/api/v1/models", headers: defaultAuthorizedHeader, body: model)
    }

    // MARK: - Patch

    func modelsPatch(id: Int, model: CarModel) -> EventLoopFuture<CarModel> {
        return patch("/api/v1/models/\(id)", headers: defaultAuthorizedHeader, body: model)
    }

    // MARK: - Publish

    func modelsPublish(id: Int) -> EventLoopFuture<CarModel> {
        return post("/api/v1/models/\(id)/publish", headers: defaultAuthorizedHeader)
    }

    // MARK: - Delete

    func modelsDelete(id: Int) -> EventLoopFuture<Void> {
        return delete("/api/v1/models/\(id)", headers: defaultAuthorizedHeader)
    }

    // MARK: - Images

    func modelsImages(id: Int) -> EventLoopFuture<[CarImage]> {
        return get("/api/v1/models/\(id)/images")
    }

    func modelsImagesDraft(id: Int) -> EventLoopFuture<[CarImage]> {
        return get("/api/v1/models/\(id)/images/draft")
    }

    // MARK: - Images

    func modelsStages(id: Int) -> EventLoopFuture<[CarStage]> {
        return get("/api/v1/models/\(id)/stages")
    }

    func modelsStagesDraft(id: Int) -> EventLoopFuture<[CarStage]> {
        return get("/api/v1/models/\(id)/stages/draft")
    }

}
