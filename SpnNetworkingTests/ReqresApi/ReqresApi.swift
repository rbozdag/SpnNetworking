//
//  ReqresApi.swift
//  SpnNetworkingTests
//
//  Created by Rahmi on 19.10.2018.
//  Copyright © 2018 RBozdag. All rights reserved.
//

import Foundation
import ObjectMapper

@testable import SpnNetworking

struct ReqresApi {

    struct ListUsersEndpoint: EndpointType {
        typealias SuccessType = ReqresUsers
        typealias ErrorType = ReqresError

        var path: String = "/users"
        var method: HTTPMethodEnum = .get
        var parameters: RequestParameters?

        init(page: Int) {
            parameters = ["page": page]
        }
    }

    struct CreateUserEndpoint: EndpointType {
        typealias SuccessType = ReqresCreateUserResponse
        typealias ErrorType = ReqresError

        var path: String = "/users"
        var method: HTTPMethodEnum = .post
        var parameters: RequestParameters?

        init(name: String, job: String) {
            parameters = ["name": name, "job": job]
        }
    }

    struct UpdateUserEndpoint: EndpointType {
        typealias SuccessType = ReqresUpdateUserResponse
        typealias ErrorType = ReqresError

        var path: String = "/users"
        var method: HTTPMethodEnum = .patch
        var parameters: RequestParameters?

        init(userId: Int, name: String, job: String) {
            path = "\(path)\(userId)"
            parameters = ["name": name, "job": job]
        }
    }

    struct DeleteUserEndpoint: EndpointType {
        typealias SuccessType = ReqresEmptyResponse
        typealias ErrorType = ReqresError

        var path: String = "/users"
        var method: HTTPMethodEnum = .delete

        init(userId: Int) {
            path = "\(path)\(userId)"
        }
    }
}


extension EndpointType where SuccessType: Codable, ErrorType: Codable {
    var parameterEncoding: ParameterEncoding {
        get { return method == .get ? ParameterEncoding.urlEncoding : ParameterEncoding.jsonEncoding }
    }

    var parameters: RequestParameters? { get { return nil } }

    var baseUrl: URL { get { return ReqresNetworkingConfiguration.shared.baseUrl } }

    var headers: RequestHTTPHeaders? { get { return nil } }

    var responseContentType: MimeTypeEnum { get { return MimeTypeEnum.applicationJson } }

    var requestChecksumGenerator: ((RequestParameters) -> String)? { get { return nil } }

    var responseChecksumValidator: ((Data) -> Bool)? { get { return nil } }

    func execute(succeed: @escaping (SuccessType) -> Void, failed: @escaping (ErrorType) -> Void) -> URLSessionTask? {
        return ReqresNetworkingConfiguration.shared.endpointRouter
            .execute(endpoint: AnyEndpoint(self), defaultHeader: ReqresNetworkingConfiguration.shared.createDefaulHeader) { status in
                switch status {
                case .requestPrepared(_):
                    break
                case .started(_):
                    break
                case .error(let error, let httpStatus):
                    self.completeWithError(error: error, httpStatus: httpStatus, failed)
                case .response(let data, let urlResponse):
                    self.onResponseHandled(data, urlResponse, succeed, failed)
                case .cancelled:
                    break
                }
        }
    }

    func onResponseHandled(_ data: Data, _ response: URLResponse, _ succeed: @escaping (SuccessType) -> Void, _ failed: @escaping (ErrorType) -> Void) {
        let httpStatusEnum = (response as? HTTPURLResponse)?.statusEnum
        let responseStatus = ReqResResponseStatusEnum.toStatusType(httpStatusCode: httpStatusEnum)

        switch responseStatus {
        case .successStatus:
            do {
                try succeed(ResponseObjectMapper.convertToObject(type: SuccessType.self, data: data))
            } catch {
                self.completeWithError(error: NetworkErrorEnum.mappingError, httpStatus: httpStatusEnum, failed)
            }
        case .errorStatus, .warningStatus:
            self.completeWithError(data: data, httpStatus: httpStatusEnum, failed)
        case .unknownStatus:
            self.completeWithError(error: NetworkErrorEnum.unknownHttpStatus, httpStatus: httpStatusEnum, failed)
        }
    }

    func completeWithError(data: Data, httpStatus: HTTPStatusCode?, _ failed: @escaping (ErrorType) -> Void) {
        do {
            let errorInstance = try ResponseObjectMapper.convertToObject(type: ErrorType.self, data: data)
            failed(errorInstance)
        } catch {
            self.completeWithError(error: NetworkErrorEnum(error), httpStatus: httpStatus, failed)
        }
    }

    func completeWithError(error: NetworkErrorEnum, httpStatus: HTTPStatusCode?, _ failed: @escaping (ErrorType) -> Void) {
        failed(ErrorType.init(with: error, httpStatus: httpStatus))
    }
}

extension EndpointType {
    func createCheckSum(_ parameters: RequestParameters?) throws -> String? {
        return nil
    }
}
