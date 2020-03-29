//
//  ClientTests.swift
//  Tests
//
//  Created by Alastair Hendricks on 2020/03/29.
//

import Quick
import Nimble
import Sakai

class ClientTests: QuickSpec {

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

        describe("sakai client") {
            it("can be torn down") {
                waitUntil(timeout: 20) { done in
                    SakaiAPIClient.shared.session.loginUser(username: SakaiTestConfiguration.pass.username, password: SakaiTestConfiguration.pass.password, completion: { (sessionResult) in
                        expect(sessionResult.error).to(beNil())
                        expect(SakaiAPIClient.shared.loggedInUserSession).toNot(beNil())

                        SakaiAPIClient.shared.teardown()
                        expect(SakaiAPIClient.shared.loggedInUserSession).to(beNil())

                        // Setup again for future tests
                        let configuration = SakaiConfiguration(baseURL: SakaiTestConfiguration.pass.baseURL)
                        SakaiAPIClient.shared.start(configuration: configuration,
                        username: SakaiTestConfiguration.pass.username,
                        password: SakaiTestConfiguration.pass.password)

                        done()
                    })
                }
            }
        }
    }
}
