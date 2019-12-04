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

//    func manufacturersCreate(manufacturer: ManufacturerModel) -> EventLoopFuture<ManufacturerModel> {
//        let body = Quack.JSONBody([
//            "name" : manufacturer.name
//        ])
//        return respond(method: .post,
//                       path: "/api/v1/manufacturers",
//                       body: body,
//                       headers: defaultAuthorizedHeader,
//                       model: ManufacturerModel.self,
//                       requestModification: jsonEncodingModification)
//    }

    // MARK: - Patch

//    func manufacturersPatch(id: Int, manufacturer: ManufacturerModel) -> EventLoopFuture<ManufacturerModel> {
//        let body = Quack.JSONBody([
//            "name" : manufacturer.name
//        ])
//        return respond(method: .patch,
//                       path: "/api/v1/manufacturers/\(id)",
//                       body: body,
//                       headers: defaultAuthorizedHeader,
//                       model: ManufacturerModel.self,
//                       requestModification: jsonEncodingModification)
//    }

    // MARK: - Delete

    func manufacturersDelete(id: Int) -> EventLoopFuture<Void> {
        return delete("/api/v1/manufacturers/\(id)", headers: defaultAuthorizedHeader)
    }

    // MARK: - Models

    func manufacturersModels(id: Int) -> EventLoopFuture<[CarModel]> {
        return get("/api/v1/manufacturers/\(id)/models")
    }

}
