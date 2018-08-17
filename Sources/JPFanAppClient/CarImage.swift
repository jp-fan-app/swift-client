//
//  CarImage.swift
//  JPFanAppClient
//
//  Created by Christoph Pageler on 17.08.18.
//


import Foundation
import Quack


public extension JPFanAppClient {

    public class CarImage: Quack.Model {

        let id: Int?
        var carModelID: Int
        var copyrightInformation: String
        let hasUpload: Bool

        public required init?(json: JSON) {
            guard let id = json["id"].int,
                let carModelID = json["carModelID"].int,
                let copyrightInformation = json["copyrightInformation"].string,
                let hasUpload = json["hasUpload"].bool
            else {
                return nil
            }

            self.id = id
            self.carModelID = carModelID
            self.copyrightInformation = copyrightInformation
            self.hasUpload = hasUpload
        }

        public init(carModelID: Int, copyrightInformation: String) {
            self.id = nil
            self.carModelID = carModelID
            self.copyrightInformation = copyrightInformation
            self.hasUpload = false
        }

        internal func jsonBody() -> Quack.JSONBody {
            return Quack.JSONBody([
                "copyrightInformation" : copyrightInformation,
                "carModelID": carModelID,
            ])
        }

    }

    public class CarImageFile: Quack.DataModel {

        let data: Data?

        public required init?(data: Data) {
            self.data = data
        }

    }

    // MARK: - Index

    public func imagesIndex() -> Quack.Result<[CarImage]> {
        return respondWithArray(method: .get,
                                path: "/api/v1/images",
                                body: nil,
                                headers: defaultHeader,
                                model: CarImage.self)
    }

    public func imagesIndex(completion: @escaping (Quack.Result<[CarImage]>) -> Void) {
        respondWithArrayAsync(method: .get,
                              path: "/api/v1/images",
                              body: nil,
                              headers: defaultHeader,
                              model: CarImage.self,
                              completion: completion)
    }

    // MARK: - Show

    public func imagesShow(id: Int) -> Quack.Result<CarImage> {
        return respond(method: .get,
                       path: "/api/v1/images/\(id)",
                       headers: defaultHeader,
                       model: CarImage.self)
    }

    public func imagesShow(id: Int,
                           completion: @escaping (Quack.Result<CarImage>) -> Void) {
        respondAsync(method: .get,
                     path: "/api/v1/images/\(id)",
                     headers: defaultHeader,
                     model: CarImage.self,
                     completion: completion)
    }

    // MARK: - Create

    public func imagesCreate(image: CarImage) -> Quack.Result<CarImage> {
        return respond(method: .post,
                       path: "/api/v1/images",
                       body: image.jsonBody(),
                       headers: defaultAuthorizedHeader,
                       model: CarImage.self,
                       requestModification: jsonEncodingModification)
    }

    public func imagesCreate(image: CarModel,
                             completion: @escaping (Quack.Result<CarImage>) -> Void) {
        respondAsync(method: .post,
                     path: "/api/v1/images",
                     body: image.jsonBody(),
                     headers: defaultAuthorizedHeader,
                     model: CarImage.self,
                     requestModification: jsonEncodingModification,
                     completion: completion)
    }

    // MARK: - Patch

    public func imagesPatch(id: Int,
                            image: CarImage) -> Quack.Result<CarImage> {
        return respond(method: .patch,
                       path: "/api/v1/images/\(id)",
                       body: image.jsonBody(),
                       headers: defaultAuthorizedHeader,
                       model: CarImage.self,
                       requestModification: jsonEncodingModification)
    }

    public func imagesPatch(id: Int,
                            image: CarImage,
                            completion: @escaping (Quack.Result<CarImage>) -> Void) {
        respondAsync(method: .patch,
                     path: "/api/v1/images/\(id)",
                     body: image.jsonBody(),
                     headers: defaultAuthorizedHeader,
                     model: CarImage.self,
                     requestModification: jsonEncodingModification,
                     completion: completion)
    }

    // MARK: - Delete

    public func imagesDelete(id: Int) -> Quack.Void {
        return respondVoid(method: .delete,
                           path: "/api/v1/images/\(id)",
                           headers: defaultAuthorizedHeader,
                           requestModification: jsonEncodingModification)
    }

    public func imagesDelete(id: Int,
                             completion: @escaping (Quack.Void) -> Void) {
        respondVoidAsync(method: .delete,
                         path: "/api/v1/images/\(id)",
                         headers: defaultAuthorizedHeader,
                         requestModification: jsonEncodingModification,
                         completion: completion)
    }

    // MARK: - Upload

    public func imagesUpload(id: Int,
                             imageData: Data) -> Quack.Void {
        let boundary = NSUUID().uuidString
        var headers = defaultAuthorizedHeader
        headers["Content-Type"] = "multipart/form-data; boundary=\(boundary)"

        let formDataBody = multipartFormDataBody(imageData: imageData,
                                                 boundary: boundary)

        let body = Quack.DataBody(formDataBody)

        return respondVoid(method: .post,
                           path: "/api/v1/images/\(id)/upload",
                           body: body,
                           headers: headers)
    }

    public func imagesUpload(id: Int,
                             imageData: Data,
                             completion: @escaping (Quack.Void) -> Void) {
        let boundary = NSUUID().uuidString
        var headers = defaultAuthorizedHeader
        headers["Content-Type"] = "multipart/form-data; boundary=\(boundary)"

        let formDataBody = multipartFormDataBody(imageData: imageData,
                                                 boundary: boundary)

        let body = Quack.DataBody(formDataBody)

        respondVoidAsync(method: .post,
                         path: "/api/v1/images/\(id)/upload",
                         body: body,
                         headers: headers,
                         completion: completion)
    }

    // MARK: - File

    public func imagesFile(id: Int) -> Quack.Result<CarImageFile> {
        return respond(method: .get,
                       path: "/api/v1/images/\(id)/file",
                       headers: defaultHeader,
                       model: CarImageFile.self)
    }

    public func imagesFile(id: Int,
                           completion: @escaping (Quack.Result<CarImageFile>) -> Void) {
        return respondAsync(method: .get,
                            path: "/api/v1/images/\(id)/file",
                            headers: defaultHeader,
                            model: CarImageFile.self,
                            completion: completion)
    }

    // MARK: - Helper

    internal func multipartFormDataBody(imageData: Data, boundary: String) -> Data {
        let mutableBody = NSMutableData()
        mutableBody.append("--\(boundary)\r\n".data(using: .utf8)!)
        mutableBody.append("Content-Disposition: form-data; name=\"image\";\r\n".data(using: .utf8)!)
        mutableBody.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        mutableBody.append(imageData)
        mutableBody.append("\r\n".data(using: .utf8)!)
        mutableBody.append("--\(boundary)--\r\n".data(using: .utf8)!)

        return mutableBody as Data
    }

}
