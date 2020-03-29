//
//  SessionTests.swift
//  Tests
//
//  Created by Alastair Hendricks on 2018/05/23.
//

import Quick
import Nimble
import Sakai

class SessionTests: QuickSpec {

    override func spec() {
        beforeSuite {
            if (SakaiTestConfiguration.pass.baseURL.absoluteString == "1") {
                fail("Please setup your Test environmental variables.")
            }
        }

        describe("session service") {
            it("logs a user in") {
                waitUntil(timeout: 20) { done in
                    let configuration = SakaiConfiguration(baseURL: SakaiTestConfiguration.pass.baseURL)
                    SakaiAPIClient.shared.start(configuration: configuration,
                                       username: SakaiTestConfiguration.pass.username,
                                       password: SakaiTestConfiguration.pass.password)
                    SakaiAPIClient.shared.session.loginUser(username: SakaiTestConfiguration.pass.username, password: SakaiTestConfiguration.pass.password, completion: { (sessionResult) in
                        expect(sessionResult.error).to(beNil())
                        expect(sessionResult.result).toNot(beNil())
                        done()
                    })
                }
            }

            

            context("if the username or password is incorrect") {
                it("fails to log a user in") {
                    waitUntil(timeout: 20) { done in
                        let configuration = SakaiConfiguration(baseURL: SakaiTestConfiguration.pass.baseURL)
                        SakaiAPIClient.shared.start(configuration: configuration,
                                           username: SakaiTestConfiguration.fail.username,
                                           password: SakaiTestConfiguration.fail.password)
                        SakaiAPIClient.shared.session.loginUser(username: SakaiTestConfiguration.fail.username, password: SakaiTestConfiguration.fail.password, completion: { (sessionResult) in
                            expect(sessionResult.result.error).toNot(beNil())
                            expect(sessionResult.result.value).to(beNil())
                            done()
                        })
                    }
                }
            }
        }
    }
}
