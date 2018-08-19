//
//  Manufacturer.swift
//  JPFanAppClient
//
//  Created by Christoph Pageler on 17.08.18.
//


import Foundation
import Quack


public extension JPFanAppClient {

    public class ManufacturerModel: Quack.Model {

        let id: Int?
        var name: String
        let createdAt: Date?
        let updatedAt: Date?

        public required init?(json: JSON) {
            guard let id = json["id"].int,
                let name = json["name"].string
            else {
                return nil
            }

            self.id = id
            self.name = name
            self.createdAt = JPFanAppClient.date(from: json["createdAt"].string)
            self.updatedAt = JPFanAppClient.date(from: json["updatedAt"].string)
        }

        public init(name: String) {
            self.id = nil
            self.name = name
            self.createdAt = nil
            self.updatedAt = nil
        }

    }

    // MARK: - Index

    public func manufacturersIndex() -> Quack.Result<[ManufacturerModel]> {
        return respondWithArray(method: .get,
                                path: "/api/v1/manufacturers",
                                headers: defaultHeader,
                                model: ManufacturerModel.self)
    }

    public func manufacturersIndex(completion: @escaping (Quack.Result<[ManufacturerModel]>) -> Void) {
        respondWithArrayAsync(method: .get,
                              path: "/api/v1/manufacturers",
                              headers: defaultHeader,
                              model: ManufacturerModel.self,
                              completion: completion)
    }

    // MARK: - Show

    public func manufacturersShow(id: Int) -> Quack.Result<ManufacturerModel> {
        return respond(method: .get,
                       path: "/api/v1/manufacturers/\(id)",
                       headers: defaultHeader,
                       model: ManufacturerModel.self)
    }

    public func manufacturersShow(id: Int,
                                  completion: @escaping (Quack.Result<ManufacturerModel>) -> Void) {
        respondAsync(method: .get,
                     path: "/api/v1/manufacturers/\(id)",
                     headers: defaultHeader,
                     model: ManufacturerModel.self,
                     completion: completion)
    }

    // MARK: - Create

    public func manufacturersCreate(manufacturer: ManufacturerModel) -> Quack.Result<ManufacturerModel> {
        let body = Quack.JSONBody([
            "name" : manufacturer.name
        ])
        return respond(method: .post,
                       path: "/api/v1/manufacturers",
                       body: body,
                       headers: defaultAuthorizedHeader,
                       model: ManufacturerModel.self,
                       requestModification: jsonEncodingModification)
    }

    public func manufacturersCreate(manufacturer: ManufacturerModel,
                                   completion: @escaping (Quack.Result<ManufacturerModel>) -> Void) {
        let body = Quack.JSONBody([
            "name" : manufacturer.name
        ])
        respondAsync(method: .post,
                     path: "/api/v1/manufacturers",
                     body: body,
                     headers: defaultAuthorizedHeader,
                     model: ManufacturerModel.self,
                     requestModification: jsonEncodingModification,
                     completion: completion)
    }

    // MARK: - Patch

    public func manufacturersPatch(id: Int,
                                   manufacturer: ManufacturerModel) -> Quack.Result<ManufacturerModel> {
        let body = Quack.JSONBody([
            "name" : manufacturer.name
        ])
        return respond(method: .patch,
                       path: "/api/v1/manufacturers/\(id)",
                       body: body,
                       headers: defaultAuthorizedHeader,
                       model: ManufacturerModel.self,
                       requestModification: jsonEncodingModification)
    }

    public func manufacturersPatch(id: Int,
                                   manufacturer: ManufacturerModel,
                                   completion: @escaping (Quack.Result<ManufacturerModel>) -> Void) {
        let body = Quack.JSONBody([
            "name" : manufacturer.name
        ])
        respondAsync(method: .patch,
                     path: "/api/v1/manufacturers/\(id)",
                     body: body,
                     headers: defaultAuthorizedHeader,
                     model: ManufacturerModel.self,
                     requestModification: jsonEncodingModification,
                     completion: completion)
    }

    // MARK: - Delete

    public func manufacturersDelete(id: Int) -> Quack.Void {
        return respondVoid(method: .delete,
                           path: "/api/v1/manufacturers/\(id)",
                           headers: defaultAuthorizedHeader,
                           requestModification: jsonEncodingModification)
    }

    public func manufacturersDelete(id: Int,
                                   completion: @escaping (Quack.Void) -> Void) {
        respondVoidAsync(method: .delete,
                         path: "/api/v1/manufacturers/\(id)",
                         headers: defaultAuthorizedHeader,
                         requestModification: jsonEncodingModification,
                         completion: completion)
    }

    // MARK: - Models

    public func manufacturersModels(id: Int) -> Quack.Result<[CarModel]> {
        return respondWithArray(method: .get,
                                path: "/api/v1/manufacturers/\(id)/models",
                                headers: defaultHeader,
                                model: CarModel.self)
    }

    public func manufacturersModels(id: Int,
                                    completion: @escaping (Quack.Result<[CarModel]>) -> Void) {
        respondWithArrayAsync(method: .get,
                              path: "/api/v1/manufacturers/\(id)/models",
                              headers: defaultHeader,
                              model: CarModel.self,
                              completion: completion)
    }

}
