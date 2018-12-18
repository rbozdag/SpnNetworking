//
//  AlamofireDispatcherRequestSpec.swift
//  SpnNetworking
//
//  Created by Rahmi on 17.10.2018.
//  Copyright © 2018 RBozdag. All rights reserved.
//

import Foundation
import Quick
import Nimble
import OHHTTPStubs

@testable import SpnNetworking

class AlamofireDispatcherRequestSpec: QuickSpec {
    override func spec() {
        describe("Using AlamofireNetworkDispatch") {
            context("Url with https://reqres.in") {
                let dispatcher = AlamofireNetworkDispatch(configuration: URLSession.shared.configuration)
                let request = URLRequest(url: URL(string: "https://reqres.in/")!)

                var completionData: Data?
                var completionResponse: URLResponse?
                var completionError: Error?

                waitUntil(timeout: 100) { done in
                    let task = dispatcher.execute(urlRequest: request, completion: { data, response, error in
                        completionData = data
                        completionResponse = response
                        completionError = error
                        done()
                    })
                    task?.resume()
                }

                it("Data should not be nil") {
                    expect(completionData).notTo(beNil())
                }

                it("Error should be nil") {
                    expect(completionError).to(beNil())
                }

                it("Response should be HTTPURLResponse") {
                    expect(completionResponse).to(beAKindOf(HTTPURLResponse.self))
                }

                it("Http status code should equal 200") {
                    let httpUrlResponse = completionResponse as! HTTPURLResponse
                    expect(httpUrlResponse.statusEnum?.rawValue).to(be(HTTPStatusCode.ok.rawValue))
                }
            }

            context("Url with Unsupported") {
                let dispatcher = AlamofireNetworkDispatch(configuration: URLSession.shared.configuration)
                let request = URLRequest(url: URL(string: "unsoppertedurlsample")!)
                var completionError: Error?
                var spnError: NetworkErrorEnum!

                waitUntil(timeout: 100) { done in
                    let task = dispatcher.execute(urlRequest: request, completion: { data, response, error in
                        completionError = error
                        spnError = NetworkErrorEnum(completionError)
                        done()
                    })
                    task?.resume()
                }

                it("Error should be unsupportedURL") {
                    expect(spnError.rawValue).to(be(NetworkErrorEnum.unsupportedURL.rawValue))
                }
            }

            context("Url with not avaliable") {
                let dispatcher = AlamofireNetworkDispatch(configuration: URLSession.shared.configuration)
                let request = URLRequest(url: URL(string: "https://cannotFindHost")!)
                var completionError: Error?
                var spnError: NetworkErrorEnum!

                waitUntil(timeout: 100) { done in
                    let task = dispatcher.execute(urlRequest: request, completion: { data, response, error in
                        completionError = error
                        spnError = NetworkErrorEnum(completionError)
                        done()
                    })
                    task?.resume()
                }

                it("Error should be cannotFindHost") {
                    expect(spnError.rawValue).to(be(NetworkErrorEnum.cannotFindHost.rawValue))
                }
            }
        }
    }
}

