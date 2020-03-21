//
//  ContentTests.swift
//  Tests
//
//  Created by Alastair Hendricks on 2020/03/21.
//

import Quick
import Nimble
import Sakai

class ContentTest: QuickSpec {

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

        describe("content service") {
            it("returns the resources for a site") {
                waitUntil(timeout: 20) { done in
                    SakaiAPIClient.shared.content.getResources(withID: SakaiTestConfiguration.pass.siteId, path: nil) { resourceResult in
                        expect(resourceResult.value?.contentCollection).toNot(beEmpty())
                        expect(resourceResult.error).to(beNil())
                        done()
                    }
                }
            }

            it("returns the resources for a folder/path") {
                waitUntil(timeout: 20) { done in
                    SakaiAPIClient.shared.content.getResources(withID: SakaiTestConfiguration.pass.siteId, path: "Test Folder") { resourceResult in
                        expect(resourceResult.value?.contentCollection).toNot(beEmpty())
                        expect(resourceResult.error).to(beNil())
                        done()
                    }
                }
            }
        }
    }
}
