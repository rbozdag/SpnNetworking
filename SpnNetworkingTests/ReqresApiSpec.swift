//
//  EndpointRouterSpec.swift
//  SpnNetworkingTests
//
//  Created by Rahmi on 19.10.2018.
//  Copyright © 2018 RBozdag. All rights reserved.
//

import Foundation
import Quick
import Nimble
import OHHTTPStubs

@testable import SpnNetworking

class ReqresApiSpec: QuickSpec {
    override func spec() {
        describe("Using ReqresApi") {
            ReqResNetworkingEnvironment.testApi.load()
            context("get users") {
                var responseUsers: ReqresUsers?
                let page = 2
                waitUntil(timeout: 100) { done in
                    ReqresApi.ListUsersEndpoint.init(page: page).execute(
                        succeed: { users in
                            responseUsers = users
                            done()
                        }, failed: { error in
                            responseUsers = nil
                            done()
                        })
                }

                it("responseUsers should not be nil") {
                    expect(responseUsers).toNot(beNil())
                }

                it("repsonse page count should be \(page)") {
                    expect(responseUsers!.page).to(be(page))
                }

                it("repsonse user count should be \(responseUsers!.perPage)") {
                    expect(responseUsers!.perPage).to(be(responseUsers!.data.count))
                }
            }

            context("create user") {
                var createdUser: ReqresCreateUserResponse?
                let userName = "user"
                let job = "adam"
                waitUntil(timeout: 100) { done in
                    ReqresApi.CreateUserEndpoint(name: userName, job: job).execute(
                        succeed: { response in
                            createdUser = response
                            done()
                        },
                        failed: { error in
                            createdUser = nil
                            done()
                        })
                }

                it("createdUser should not be nil") {
                    expect(createdUser).toNot(beNil())
                }

                it("createdUser name should be \(userName)") {
                    expect(createdUser?.name).to(be(userName))
                }

                it("createdUser job should be \(job)") {
                    expect(createdUser?.job).to(be(job))
                }
            }

            context("update user") {
                var updatedUser: ReqresUpdateUserResponse?
                let userName = "user"
                let job = "adam"
                waitUntil(timeout: 100) { done in
                    ReqresApi.UpdateUserEndpoint(userId: 2, name: userName, job: job).execute(
                        succeed: { response in
                            updatedUser = response
                            done()
                        },
                        failed: { error in
                            updatedUser = nil
                            done()
                        })
                }

                it("createdUser should not be nil") {
                    expect(updatedUser).toNot(beNil())
                }

                it("createdUser should not be nil") {
                    expect(updatedUser?.updatedAt).toNot(beNil())
                }

                it("createdUser name should be \(userName)") {
                    expect(updatedUser?.name).to(be(userName))
                }

                it("createdUser job should be \(job)") {
                    expect(updatedUser?.job).to(be(job))
                }
            }
            
            context("delete user") {
                var emptyResponse: ReqresEmptyResponse?
                waitUntil(timeout: 100) { done in
                    ReqresApi.DeleteUserEndpoint(userId: 2).execute(
                        succeed: { response in
                            emptyResponse = response
                            done()
                    },
                        failed: { error in
                            emptyResponse = nil
                            done()
                    })
                }
                
                it("emptyResponse should not be nil") {
                    //TODO expect(emptyResponse).toNot(beNil())
                }
            }
        }
    }
}
