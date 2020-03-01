//
//  Client.swift
//  JPFanAppClient
//
//  Created by Christoph Pageler on 17.08.18.
//


import Foundation
import AsyncHTTPClient
import NIO
import NIOHTTP1


public class JPFanAppClient {

    private let accessToken: String
    public var authToken: String? = nil

    internal var baseURL: URL
    internal var carImagesBaseURL: URL
    internal let client = HTTPClient(eventLoopGroupProvider: .createNew,
                                     configuration: HTTPClient.Configuration())

    internal var defaultHeader: HTTPHeaders {
        HTTPHeaders([
            ("Content-Type", "application/json"),
            ("x-access-token", accessToken)
        ])
    }

    internal var defaultAuthorizedHeader: HTTPHeaders {
        HTTPHeaders([
            ("Content-Type", "application/json"),
            ("Authorization", "Bearer \(authToken ?? "")"),
            ("x-access-token", accessToken)
        ])
    }

    internal let jsonDecoder = JSONDecoder()
    internal let jsonEncoder = JSONEncoder()

    public static func production(accessToken: String) -> JPFanAppClient {
        return JPFanAppClient(accessToken: accessToken,
                              baseURL: URL(string: "https://api.jp-fan-app.de")!,
                              carImagesBaseURL: URL(string: "https://car-images.jp-fan-app.de")!)
    }

    // MARK: - Init

    public init(accessToken: String, baseURL: URL, carImagesBaseURL: URL) {
        self.baseURL = baseURL
        self.carImagesBaseURL = carImagesBaseURL
        self.accessToken = accessToken

        jsonDecoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)
            return JPFanAppClient.dateFormatter.date(from: dateStr) ?? Date()
        })
    }

    deinit {
        try? client.syncShutdown()
    }

    // MARK: - Make Requests

    internal func submit<T: Decodable>(request: HTTPClient.Request) -> EventLoopFuture<T> {
        return client.execute(request: request).flatMapThrowing { response in
            guard response.status.code < 400 else {
                throw ClientError.httpError(response.status.code)
            }

            guard var body = response.body else {
                throw ClientError.noBodyError(response.status.code)
            }

            guard let response = body.readBytes(length: body.readableBytes) else {
                throw ClientError.couldNotReadBody
            }

            do {
                return try self.jsonDecoder.decode(T.self, from: Data(response))
            } catch(let error) {
                print(error)
                throw ClientError.parsing
            }
        }
    }

    internal func submit(request: HTTPClient.Request) -> EventLoopFuture<Void> {
        return client.execute(request: request).flatMapThrowing { response in
            guard response.status == .ok else {
                throw ClientError.httpError(response.status.code)
            }

            return
        }
    }

    internal func makeRequest<Body: Codable, T: Decodable>(_ path: String,
                                                           method: HTTPMethod,
                                                           headers: HTTPHeaders,
                                                           body: Body) -> EventLoopFuture<T> {
        do {
            return try makeRequest(path, method: method, headers: headers, data: jsonEncoder.encode(body))
        } catch {
            return client.eventLoopGroup.next().makeFailedFuture(error)
        }
    }

    internal func makeRequest<T: Decodable>(_ path: String,
                                            method: HTTPMethod,
                                            headers: HTTPHeaders,
                                            data: Data) -> EventLoopFuture<T> {
        do {
            let request = try HTTPClient.Request(url: baseURL.appendingPathComponent(path),
                                                 method: method,
                                                 headers: headers,
                                                 body: HTTPClient.Body.data(data))
            return submit(request: request)
        } catch {
            return client.eventLoopGroup.next().makeFailedFuture(error)
        }
    }

    internal func makeRequest(_ path: String,
                              method: HTTPMethod,
                              headers: HTTPHeaders,
                              data: Data) -> EventLoopFuture<Void> {
        do {
            let request = try HTTPClient.Request(url: baseURL.appendingPathComponent(path),
                                                 method: method,
                                                 headers: headers,
                                                 body: HTTPClient.Body.data(data))
            return submit(request: request)
        } catch {
            return client.eventLoopGroup.next().makeFailedFuture(error)
        }
    }

    internal func makeRequest<T: Decodable>(_ path: String,
                                            method: HTTPMethod,
                                            headers: HTTPHeaders) -> EventLoopFuture<T> {
        do {
            let request = try HTTPClient.Request(url: baseURL.appendingPathComponent(path),
                                                 method: method,
                                                 headers: headers)
            return submit(request: request)
        } catch {
            return client.eventLoopGroup.next().makeFailedFuture(error)
        }
    }

    internal func makeRequest<Body: Codable>(_ path: String,
                                             method: HTTPMethod,
                                             headers: HTTPHeaders,
                                             body: Body) -> EventLoopFuture<Void> {
        do {
            let request = try HTTPClient.Request(url: baseURL.appendingPathComponent(path),
                                                 method: method,
                                                 headers: headers,
                                                 body: HTTPClient.Body.data(jsonEncoder.encode(body)))
            return submit(request: request)
        } catch {
            return client.eventLoopGroup.next().makeFailedFuture(error)
        }
    }

    internal func makeRequest(_ path: String, method: HTTPMethod, headers: HTTPHeaders) -> EventLoopFuture<Void> {
        do {
            let request = try HTTPClient.Request(url: baseURL.appendingPathComponent(path),
                                                 method: method,
                                                 headers: headers)
            return submit(request: request)
        } catch {
            return client.eventLoopGroup.next().makeFailedFuture(error)
        }
    }

    // MARK: - Get

    internal func get<Body: Codable, T: Decodable>(_ path: String, headers: HTTPHeaders, body: Body) -> EventLoopFuture<T> {
        return makeRequest(path, method: .GET, headers: headers, body: body)
    }

    internal func get<T: Decodable>(_ path: String, headers: HTTPHeaders) -> EventLoopFuture<T> {
        return makeRequest(path, method: .GET, headers: headers)
    }

    internal func get<T: Decodable>(_ path: String) -> EventLoopFuture<T> {
        return makeRequest(path, method: .GET, headers: defaultHeader)
    }

    internal func getData(baseURL: URL?, _ path: String) -> EventLoopFuture<Data> {
        do {
            let baseURL = baseURL ?? self.baseURL
            let request = try HTTPClient.Request(url: baseURL.appendingPathComponent(path),
                                                 method: .GET,
                                                 headers: defaultHeader)
            return client.execute(request: request).flatMapThrowing { response in
                guard response.status.code < 400 else {
                    throw ClientError.httpError(response.status.code)
                }

                guard var body = response.body else {
                    throw ClientError.noBodyError(response.status.code)
                }

                guard let response = body.readBytes(length: body.readableBytes) else {
                    throw ClientError.couldNotReadBody
                }

                return Data(response)
            }
        } catch {
            return client.eventLoopGroup.next().makeFailedFuture(error)
        }
    }

    // MARK: - Post

    internal func post<Body: Codable, T: Decodable>(_ path: String, headers: HTTPHeaders, body: Body) -> EventLoopFuture<T> {
        return makeRequest(path, method: .POST, headers: headers, body: body)
    }

    internal func post<T: Decodable>(_ path: String, headers: HTTPHeaders) -> EventLoopFuture<T> {
        return makeRequest(path, method: .POST, headers: headers)
    }

    internal func post<Body: Codable>(_ path: String, headers: HTTPHeaders, body: Body) -> EventLoopFuture<Void> {
        return makeRequest(path, method: .POST, headers: headers, body: body)
    }

    internal func post(_ path: String, headers: HTTPHeaders, data: Data) -> EventLoopFuture<Void> {
        return makeRequest(path, method: .POST, headers: headers, data: data)
    }

    internal func post(_ path: String, headers: HTTPHeaders) -> EventLoopFuture<Void> {
        return makeRequest(path, method: .POST, headers: headers)
    }

    // MARK: - Patch

    internal func patch<Body: Codable, T: Decodable>(_ path: String, headers: HTTPHeaders, body: Body) -> EventLoopFuture<T> {
        return makeRequest(path, method: .PATCH, headers: headers, body: body)
    }

    internal func patch<Body: Codable>(_ path: String, headers: HTTPHeaders, body: Body) -> EventLoopFuture<Void> {
        return makeRequest(path, method: .PATCH, headers: headers, body: body)
    }

    // MARK: - Delete

    internal func delete<Body: Codable, T: Decodable>(_ path: String, headers: HTTPHeaders, body: Body) -> EventLoopFuture<T> {
        return makeRequest(path, method: .DELETE, headers: headers, body: body)
    }

    internal func delete<Body: Codable>(_ path: String, headers: HTTPHeaders, body: Body) -> EventLoopFuture<Void> {
        return makeRequest(path, method: .DELETE, headers: headers, body: body)
    }

    internal func delete(_ path: String, headers: HTTPHeaders) -> EventLoopFuture<Void> {
        return makeRequest(path, method: .DELETE, headers: headers)
    }

    // MARK: - Other

    public func nextEventLoop() -> EventLoop {
        return client.eventLoopGroup.next()
    }

    internal static var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return df
    }

}


public extension JPFanAppClient {

    enum ClientError: Swift.Error {

        case httpError(UInt)
        case noBodyError(UInt)
        case couldNotReadBody
        case parsing

    }

}
