//
//  CarModel.swift
//  JPFanAppClient
//
//  Created by Christoph Pageler on 17.08.18.
//


import Foundation
import Quack


public extension JPFanAppClient {

    public class CarModel: Quack.Model {

        public enum TransmissionType: Int, Codable {

            case manual
            case automatic

        }

        public enum AxleType: Int, Codable {

            case all
            case front
            case rear

        }

        let id: Int?
        var name: String
        var manufacturerID: Int
        var transmissionType: TransmissionType
        var axleType: AxleType
        var mainImageID: Int?
        let createdAt: Date?
        let updatedAt: Date?

        public required init?(json: JSON) {
            guard let id = json["id"].int,
                let name = json["name"].string,
                let manufacturerID = json["manufacturerID"].int,
                let transmissionTypeInt = json["transmissionType"].int,
                let transmissionType = TransmissionType(rawValue: transmissionTypeInt),
                let axleTypeInt = json["axleType"].int,
                let axleType = AxleType(rawValue: axleTypeInt)
            else {
                return nil
            }

            self.id = id
            self.name = name
            self.manufacturerID = manufacturerID
            self.transmissionType = transmissionType
            self.axleType = axleType
            self.mainImageID = json["mainImageID"].int
            self.createdAt = JPFanAppClient.date(from: json["createdAt"].string)
            self.updatedAt = JPFanAppClient.date(from: json["updatedAt"].string)
        }

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

        internal func jsonBody() -> Quack.JSONBody {
            return Quack.JSONBody([
                "name" : name,
                "manufacturerID": manufacturerID,
                "transmissionType": transmissionType.rawValue,
                "axleType": axleType.rawValue,
                "mainImageID": (mainImageID as Any)
            ])
        }

    }

    // MARK: - Index

    public func modelsIndex() -> Quack.Result<[CarModel]> {
        return respondWithArray(method: .get,
                                path: "/api/v1/models",
                                headers: defaultHeader,
                                model: CarModel.self)
    }

    public func modelsIndex(completion: @escaping (Quack.Result<[CarModel]>) -> Void) {
        respondWithArrayAsync(method: .get,
                              path: "/api/v1/models",
                              headers: defaultHeader,
                              model: CarModel.self,
                              completion: completion)
    }

    // MARK: - Show

    public func modelsShow(id: Int) -> Quack.Result<CarModel> {
        return respond(method: .get,
                       path: "/api/v1/models/\(id)",
                       headers: defaultHeader,
                       model: CarModel.self)
    }

    public func modelsShow(id: Int,
                           completion: @escaping (Quack.Result<CarModel>) -> Void) {
        respondAsync(method: .get,
                     path: "/api/v1/models/\(id)",
                     headers: defaultHeader,
                     model: CarModel.self,
                     completion: completion)
    }

    // MARK: - Create

    public func modelsCreate(model: CarModel) -> Quack.Result<CarModel> {
        return respond(method: .post,
                       path: "/api/v1/models",
                       body: model.jsonBody(),
                       headers: defaultAuthorizedHeader,
                       model: CarModel.self,
                       requestModification: jsonEncodingModification)
    }

    public func modelsCreate(model: CarModel,
                             completion: @escaping (Quack.Result<CarModel>) -> Void) {
        respondAsync(method: .post,
                     path: "/api/v1/models",
                     body: model.jsonBody(),
                     headers: defaultAuthorizedHeader,
                     model: CarModel.self,
                     requestModification: jsonEncodingModification,
                     completion: completion)
    }

    // MARK: - Patch

    public func modelsPatch(id: Int,
                            model: CarModel) -> Quack.Result<CarModel> {
        return respond(method: .patch,
                       path: "/api/v1/models/\(id)",
                       body: model.jsonBody(),
                       headers: defaultAuthorizedHeader,
                       model: CarModel.self,
                       requestModification: jsonEncodingModification)
    }

    public func modelsPatch(id: Int,
                            model: CarModel,
                            completion: @escaping (Quack.Result<CarModel>) -> Void) {
        respondAsync(method: .patch,
                     path: "/api/v1/models/\(id)",
                     body: model.jsonBody(),
                     headers: defaultAuthorizedHeader,
                     model: CarModel.self,
                     requestModification: jsonEncodingModification,
                     completion: completion)
    }

    // MARK: - Delete

    public func modelsDelete(id: Int) -> Quack.Void {
        return respondVoid(method: .delete,
                           path: "/api/v1/models/\(id)",
                           headers: defaultAuthorizedHeader,
                           requestModification: jsonEncodingModification)
    }

    public func modelsDelete(id: Int,
                             completion: @escaping (Quack.Void) -> Void) {
        respondVoidAsync(method: .delete,
                         path: "/api/v1/models/\(id)",
                         headers: defaultAuthorizedHeader,
                         requestModification: jsonEncodingModification,
                         completion: completion)
    }

    // MARK: - Images

    public func modelsImages(id: Int) -> Quack.Result<[CarImage]> {
        return respondWithArray(method: .get,
                                path: "/api/v1/models/\(id)/images",
                                headers: defaultHeader,
                                model: CarImage.self)
    }

    public func modelsImages(id: Int,
                             completion: @escaping (Quack.Result<[CarImage]>) -> Void) {
        respondWithArrayAsync(method: .get,
                              path: "/api/v1/models/\(id)/images",
                              headers: defaultHeader,
                              model: CarImage.self,
                              completion: completion)
    }

    // MARK: - Images

    public func modelsStages(id: Int) -> Quack.Result<[CarStage]> {
        return respondWithArray(method: .get,
                                path: "/api/v1/models/\(id)/stages",
                                headers: defaultHeader,
                                model: CarStage.self)
    }

    public func modelsStages(id: Int,
                             completion: @escaping (Quack.Result<[CarStage]>) -> Void) {
        respondWithArrayAsync(method: .get,
                              path: "/api/v1/models/\(id)/stages",
                              headers: defaultHeader,
                              model: CarStage.self,
                              completion: completion)
    }

}
