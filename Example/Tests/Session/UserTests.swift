//
//  UserTests.swift
//  Tests
//
//  Created by Alastair Hendricks on 2020/03/29.
//

import Quick
import Nimble
import Sakai

class UserTests: QuickSpec {

    override func spec() {
        beforeSuite {
            if (SakaiTestConfiguration.pass.baseURL.absoluteString == "1") {
                fail("Please setup your Test environmental variables.")
            }

            let configuration = SakaiConfiguration(baseURL: SakaiTestConfiguration.pass.baseURL)
            SakaiAPIClient.shared.start(configuration: configuration,
                               username: SakaiTestConfiguration.pass.username,
                               password: SakaiTestConfiguration.pass.password)
        }

        describe("session service") {
            context("with a logged in user") {
                it("can get the user's profile") {
                    waitUntil(timeout: 20) { done in
                        SakaiAPIClient.shared.session.loginUser(username: SakaiTestConfiguration.pass.username, password: SakaiTestConfiguration.pass.password, completion: { (sessionResult) in
                            expect(sessionResult.error).to(beNil())

                            guard let loggedInUser = SakaiAPIClient.shared.loggedInUserSession else {
                                fail("Unable to get logged in user")
                                done()
                                return
                            }
                            SakaiAPIClient.shared.session.getUserProfile(uid: loggedInUser.userId) { result in
                                expect(result.value).toNot(beNil())
                                expect(result.error).to(beNil())
                                done()
                            }
                        })
                    }
                }
            }
        }
    }
}

