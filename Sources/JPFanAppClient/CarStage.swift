//
//  CarStage.swift
//  JPFanAppClient
//
//  Created by Christoph Pageler on 17.08.18.
//


import Foundation
import Quack


public extension JPFanAppClient {

    public class CarStage: Quack.Model {

        let id: Int?
        var carModelID: Int
        var name: String
        let isStock: Bool

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
            self.isStock = isStock
        }

        public init(carModelID: Int, name: String, isStock: Bool) {
            self.id = nil
            self.carModelID = carModelID
            self.name = name
            self.isStock = isStock
        }

        internal func jsonBody() -> Quack.JSONBody {
            return Quack.JSONBody([
                "carModelID": carModelID,
                "name": name,
                "isStock": isStock
            ])
        }

    }

    // MARK: - Index

    public func stagesIndex() -> Quack.Result<[CarStage]> {
        return respondWithArray(method: .get,
                                path: "/api/v1/stages",
                                body: nil,
                                headers: defaultHeader,
                                model: CarStage.self)
    }

    public func stagesIndex(completion: @escaping (Quack.Result<[CarStage]>) -> Void) {
        respondWithArrayAsync(method: .get,
                              path: "/api/v1/stages",
                              body: nil,
                              headers: defaultHeader,
                              model: CarStage.self,
                              completion: completion)
    }

    // MARK: - Show

    public func stagesShow(id: Int) -> Quack.Result<CarStage> {
        return respond(method: .get,
                       path: "/api/v1/stages/\(id)",
                       headers: defaultHeader,
                       model: CarStage.self)
    }

    public func stagesShow(id: Int,
                           completion: @escaping (Quack.Result<CarStage>) -> Void) {
        respondAsync(method: .get,
                     path: "/api/v1/stages/\(id)",
                     headers: defaultHeader,
                     model: CarStage.self,
                     completion: completion)
    }

    // MARK: - Create

    public func stagesCreate(stage: CarStage) -> Quack.Result<CarStage> {
        return respond(method: .post,
                       path: "/api/v1/stages",
                       body: stage.jsonBody(),
                       headers: defaultAuthorizedHeader,
                       model: CarStage.self,
                       requestModification: jsonEncodingModification)
    }

    public func stagesCreate(stage: CarStage,
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

    public func stagesPatch(id: Int,
                            stage: CarStage) -> Quack.Result<CarStage> {
        return respond(method: .patch,
                       path: "/api/v1/stages/\(id)",
                       body: stage.jsonBody(),
                       headers: defaultAuthorizedHeader,
                       model: CarStage.self,
                       requestModification: jsonEncodingModification)
    }

    public func stagesPatch(id: Int,
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

    public func stagesDelete(id: Int) -> Quack.Void {
        return respondVoid(method: .delete,
                           path: "/api/v1/stages/\(id)",
                           headers: defaultAuthorizedHeader,
                           requestModification: jsonEncodingModification)
    }

    public func stagesDelete(id: Int,
                             completion: @escaping (Quack.Void) -> Void) {
        respondVoidAsync(method: .delete,
                         path: "/api/v1/stages/\(id)",
                         headers: defaultAuthorizedHeader,
                         requestModification: jsonEncodingModification,
                         completion: completion)
    }

    // MARK: - Timings

    public func stagesTimings(id: Int) -> Quack.Result<[StageTiming]> {
        return respondWithArray(method: .get,
                                path: "/api/v1/stages/\(id)/timings",
                                headers: defaultHeader,
                                model: StageTiming.self)
    }

    public func stagesTimings(id: Int,
                              completion: @escaping (Quack.Result<[StageTiming]>) -> Void) {
        respondWithArrayAsync(method: .get,
                              path: "/api/v1/stages/\(id)/timings",
                              headers: defaultHeader,
                              model: StageTiming.self,
                              completion: completion)
    }

}
