//
//  EndpointProtocol.swift
//  SpnNetworking
//
//  Created by Rahmi on 1.10.2018.
//  Copyright © 2018 RBozdag. All rights reserved.
// #Description:  What is an Endpoint? Well, essentially it is a URLRequest with all its comprising components such as headers, query parameters, and body parameters. The EndpointType protocol is the cornerstone of our network layers implementation.
//

import Foundation

public protocol EndpointType {
    associatedtype SuccessType
    associatedtype ErrorType: NetworkErrorType

    var baseUrl: URL { get }
    var path: String { get }
    var method: HTTPMethodEnum { get }
    var responseContentType: MimeTypeEnum { get }
    var parameters: RequestParameters? { get }
    var headers: RequestHTTPHeaders? { get }
    var parameterEncoding: ParameterEncoding { get }

    var requestChecksumGenerator: ((RequestParameters) -> String)? { get }
    var responseChecksumValidator: ((Data) -> Bool)? { get }

    func execute(succeed: @escaping (SuccessType) -> Void, failed: @escaping (ErrorType) -> Void) -> URLSessionTask?
}

public class AnyEndpoint<E: EndpointType>: EndpointType {
    private let endpoint: E
    public var baseUrl: URL { get { return endpoint.baseUrl } }
    public var path: String { get { return endpoint.path } }
    public var method: HTTPMethodEnum { get { return endpoint.method } }
    public var parameters: RequestParameters? { get { return endpoint.parameters } }
    public var headers: RequestHTTPHeaders? { get { return endpoint.headers } }
    public var parameterEncoding: ParameterEncoding { get { return endpoint.parameterEncoding } }
    public var responseContentType: MimeTypeEnum { get { return endpoint.responseContentType } }

    public var requestChecksumGenerator: ((RequestParameters) -> String)? { get { return endpoint.requestChecksumGenerator } }
    public var responseChecksumValidator: ((Data) -> Bool)? { get { return endpoint.responseChecksumValidator } }

    public func execute(succeed: @escaping (E.SuccessType) -> Void, failed: @escaping (E.ErrorType) -> Void) -> URLSessionTask? {
        return endpoint.execute(succeed: succeed, failed: failed)
    }

    public init(_ endpoint: E) {
        self.endpoint = endpoint
    }
}
