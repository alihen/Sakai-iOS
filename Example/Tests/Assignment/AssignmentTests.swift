//
//  AssignmentTests.swift
//  Tests
//
//  Created by Alastair Hendricks on 2020/04/08.
//

import Quick
import Nimble
import Sakai

class AssignmentTests: QuickSpec {

    override func spec() {
        beforeSuite {
            if (SakaiTestConfiguration.pass.baseURL.absoluteString == "1" || SakaiTestConfiguration.pass.assignmentId == "1") {
                fail("Please setup your Test environmental variables.")
            }

            let configuration = SakaiConfiguration(baseURL: SakaiTestConfiguration.pass.baseURL)
            SakaiAPIClient.shared.start(configuration: configuration,
                               username: SakaiTestConfiguration.pass.username,
                               password: SakaiTestConfiguration.pass.password)
        }

        describe("assignment service") {
            it("can retrieve all assignments") {
                waitUntil(timeout: 20) { done in
                    SakaiAPIClient.shared.assignement.getSiteAssignments(siteId: SakaiTestConfiguration.pass.siteId) { result in
                        expect(result.value).toNot(beNil())
                        expect(result.error).to(beNil())
                        done()
                    }
                }
            }

            it("can retrieve an assignment item") {
                waitUntil(timeout: 20) { done in
                    SakaiAPIClient.shared.assignement.getAssignmentItem(id: SakaiTestConfiguration.pass.assignmentId) { result in
                        expect(result.value).toNot(beNil())
                        expect(result.error).to(beNil())
                        done()
                    }
                }
            }

            it("can retrieve a user's assignments") {
                waitUntil(timeout: 20) { done in
                    SakaiAPIClient.shared.assignement.getUserAssignments { result in
                        expect(result.value).toNot(beNil())
                        expect(result.error).to(beNil())
                        done()
                    }
                }
            }

            it("attempts to retrieve a assignment item but fails") {
                waitUntil(timeout: 20) { done in
                    SakaiAPIClient.shared.assignement.getAssignmentItem(id: SakaiTestConfiguration.fail.assignmentId) { result in
                        expect(result.value).to(beNil())
                        expect(result.error).toNot(beNil())
                        done()
                    }
                }
            }
        }
    }
}
