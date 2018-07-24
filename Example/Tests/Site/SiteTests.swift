//
//  SiteTests.swift
//  Tests
//
//  Created by Alastair Hendricks on 2018/05/23.
//

import Quick
import Nimble
import Sakai

class SiteTest: QuickSpec {

    override func spec() {
        beforeSuite {
            if (SakaiTestConfiguration.pass.baseURL.absoluteString == "1") {
                fail("Please setup your Test environmental variables.")
            }

            let configuration = SakaiConfiguration(baseURL: SakaiTestConfiguration.pass.baseURL)
            Sakai.shared.start(configuration: configuration,
                               username: SakaiTestConfiguration.pass.username,
                               password: SakaiTestConfiguration.pass.password)
        }

        describe("site service") {
            it("returns a single site by ID") {
                waitUntil(timeout: 20) { done in
                    Sakai.shared.site.getSite(withID: SakaiTestConfiguration.pass.siteId, completion: { (siteResult) in
                        expect(siteResult.error).to(beNil())
                        expect(siteResult.result?.id).toNot(beNil())
                        done()
                    })
                }
            }

            context("if the site id does note exist") {
                it("fails to return a single site by ID") {
                    waitUntil(timeout: 20) { done in
                        Sakai.shared.site.getSite(withID: SakaiTestConfiguration.fail.siteId, completion: { (siteResult) in
                            expect(siteResult.error).toNot(beNil())
                            expect(siteResult.result).to(beNil())
                            done()
                        })
                    }
                }
            }

            it("returns all the sites") {
                waitUntil(timeout: 50) { done in
                    Sakai.shared.site.getAllSites(completion: { (siteResults) in
                        expect(siteResults.error).to(beNil())
                        expect(siteResults.result).toNot(beEmpty())
                        done()
                    })
                }
            }
        }
    }
}
