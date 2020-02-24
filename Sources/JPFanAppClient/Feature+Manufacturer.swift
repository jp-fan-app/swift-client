//
//  Manufacturer.swift
//  JPFanAppClient
//
//  Created by Christoph Pageler on 17.08.18.
//


import Foundation
import AsyncHTTPClient
import NIO


public extension JPFanAppClient {

    struct ManufacturerModel: Codable {

        public let id: Int?
        public var name: String
        public let createdAt: Date?
        public let updatedAt: Date?

        public init(name: String) {
            self.id = nil
            self.name = name
            self.createdAt = nil
            self.updatedAt = nil
        }

    }

    // MARK: - Index

    func manufacturersIndex() -> EventLoopFuture<[ManufacturerModel]> {
        return get("/api/v1/manufacturers")
    }

    // MARK: - Show

    func manufacturersShow(id: Int) -> EventLoopFuture<ManufacturerModel> {
        return get("/api/v1/manufacturers/\(id)")
    }

    // MARK: - Create

    struct ManufacturerEdit: Codable {

        public let name: String

        public init(name: String) {
            self.name = name
        }

    }

    func manufacturersCreate(_ manufacturer: ManufacturerEdit) -> EventLoopFuture<ManufacturerModel> {
        return post("/api/v1/manufacturers",
                    headers: defaultAuthorizedHeader,
                    body: manufacturer)
    }

    // MARK: - Patch

    func manufacturersPatch(id: Int, manufacturer: ManufacturerEdit) -> EventLoopFuture<ManufacturerModel> {
        return patch("/api/v1/manufacturers/\(id)",
                     headers: defaultAuthorizedHeader,
                     body: manufacturer)
    }

    // MARK: - Delete

    func manufacturersDelete(id: Int) -> EventLoopFuture<Void> {
        return delete("/api/v1/manufacturers/\(id)", headers: defaultAuthorizedHeader)
    }

    // MARK: - Models

    func manufacturersModels(id: Int) -> EventLoopFuture<[CarModel]> {
        return get("/api/v1/manufacturers/\(id)/models")
    }

}
