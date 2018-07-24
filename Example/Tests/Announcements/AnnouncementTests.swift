//
//  AnnouncementTests.swift
//  Tests
//
//  Created by Alastair Hendricks on 2018/05/23.
//

import Quick
import Nimble
import Sakai

class AnnouncementTest: QuickSpec {

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

        describe("announcement service") {
            it("returns a single announcement by ID") {
                waitUntil(timeout: 20) { done in
                    Sakai.shared.announcements.getAnnouncement(withID: SakaiTestConfiguration.pass.announcementId, completion: { (announcementResult) in
                        expect(announcementResult.error).to(beNil())
                        expect(announcementResult.result?.announcementId).toNot(beNil())
                        done()
                    })
                }
            }

            context("if the accouncement id is incorrect") {
                it("it failes to return a single announcement by ID") {
                    waitUntil(timeout: 20) { done in
                        Sakai.shared.announcements.getAnnouncement(withID: SakaiTestConfiguration.fail.announcementId, completion: { (announcementResult) in
                            expect(announcementResult.error).toNot(beNil())
                            expect(announcementResult.result).to(beNil())
                            done()
                        })
                    }
                }
            }


            it("returns the recent announcements") {
                waitUntil(timeout: 20) { done in
                    Sakai.shared.announcements.getRecentAnnouncements(completion: { (announcementResults) in
                        expect(announcementResults.error).to(beNil())
                        expect(announcementResults.result).toNot(beEmpty())
                        done()
                    })
                }
            }
        }
    }
}
