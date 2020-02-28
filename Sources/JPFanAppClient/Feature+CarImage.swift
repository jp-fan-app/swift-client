//
//  CarImage.swift
//  JPFanAppClient
//
//  Created by Christoph Pageler on 17.08.18.
//


import Foundation
import AsyncHTTPClient
import NIO


public extension JPFanAppClient {

    struct CarImage: Codable {

        public let id: Int?
        public var carModelID: Int
        public var copyrightInformation: String
        public let hasUpload: Bool
        public let createdAt: Date?
        public let updatedAt: Date?

        public init(carModelID: Int, copyrightInformation: String) {
            self.id = nil
            self.carModelID = carModelID
            self.copyrightInformation = copyrightInformation
            self.hasUpload = false
            self.createdAt = nil
            self.updatedAt = nil
        }

    }

    // MARK: - Index

    func imagesIndex() -> EventLoopFuture<[CarImage]> {
        return get("/api/v1/images")
    }

    func imagesIndexDraft() -> EventLoopFuture<[CarImage]> {
        return get("/api/v1/images/draft")
    }

    // MARK: - Show

    func imagesShow(id: Int) -> EventLoopFuture<CarImage> {
        return get("/api/v1/images/\(id)")
    }

    // MARK: - Create

    func imagesCreate(image: CarImage) -> EventLoopFuture<CarImage> {
        return post("/api/v1/images", headers: defaultAuthorizedHeader, body: image)
    }

    // MARK: - Patch

    func imagesPatch(id: Int, image: CarImage) -> EventLoopFuture<CarImage> {
        return patch("/api/v1/images/\(id)", headers: defaultAuthorizedHeader, body: image)
    }

    // MARK: - Publish

    func imagesPublish(id: Int) -> EventLoopFuture<CarImage> {
        return post("/api/v1/images/\(id)/publish", headers: defaultAuthorizedHeader)
    }

    // MARK: - Delete

    func imagesDelete(id: Int) -> EventLoopFuture<Void> {
        return delete("/api/v1/images/\(id)", headers: defaultAuthorizedHeader)
    }

    // MARK: - Upload

//    func imagesUpload(id: Int, imageData: Data) -> EventLoopFuture<Void> {
//        let boundary = NSUUID().uuidString
//        var headers = defaultAuthorizedHeader
//        headers["Content-Type"] = "multipart/form-data; boundary=\(boundary)"
//
//        let formDataBody = multipartFormDataBody(imageData: imageData,
//                                                 boundary: boundary)
//
//        let body = Quack.DataBody(formDataBody)
//
//        return respondVoid(method: .post,
//                           path: "/api/v1/images/\(id)/upload",
//                           body: body,
//                           headers: headers)
//    }

    // MARK: - File

    func imagesFile(id: Int) -> EventLoopFuture<Data> {
        return getData(baseURL: carImagesBaseURL, "\(id).jpg")
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
