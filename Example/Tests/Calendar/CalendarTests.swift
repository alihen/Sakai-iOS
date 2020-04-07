//
//  CalendarTests.swift
//  Tests
//
//  Created by Alastair Hendricks on 2020/04/07.
//

import Quick
import Nimble
import Sakai

class CalendarTests: QuickSpec {

    override func spec() {
        beforeSuite {
            if (SakaiTestConfiguration.pass.baseURL.absoluteString == "1" || SakaiTestConfiguration.pass.eventId == "1") {
                fail("Please setup your Test environmental variables.")
            }

            let configuration = SakaiConfiguration(baseURL: SakaiTestConfiguration.pass.baseURL)
            SakaiAPIClient.shared.start(configuration: configuration,
                               username: SakaiTestConfiguration.pass.username,
                               password: SakaiTestConfiguration.pass.password)
        }

        describe("calendar service") {
            it("can retrieve all calendar events") {
                waitUntil(timeout: 20) { done in
                    SakaiAPIClient.shared.calendar.getSiteCalendar(siteId: SakaiTestConfiguration.pass.siteId) { result in
                        expect(result.value).toNot(beNil())
                        expect(result.error).to(beNil())
                        done()
                    }
                }
            }

            it("can retrieve a calendar event") {
                waitUntil(timeout: 20) { done in
                    SakaiAPIClient.shared.calendar.getSiteCalendarEvent(siteId: SakaiTestConfiguration.pass.siteId, eventId: SakaiTestConfiguration.pass.eventId) { result in
                        expect(result.value).toNot(beNil())
                        expect(result.error).to(beNil())
                        done()
                    }
                }
            }

            it("can retrieve a user's calendar") {
                waitUntil(timeout: 20) { done in
                    SakaiAPIClient.shared.calendar.getUserCalendar { result in
                        expect(result.value).toNot(beNil())
                        expect(result.error).to(beNil())
                        done()
                    }
                }
            }

            it("attempts to retrieve a calendar event but fails") {
                waitUntil(timeout: 20) { done in
                    SakaiAPIClient.shared.calendar.getSiteCalendarEvent(siteId: SakaiTestConfiguration.pass.siteId, eventId: SakaiTestConfiguration.fail.eventId) { result in
                        expect(result.value).to(beNil())
                        expect(result.error).toNot(beNil())
                        done()
                    }
                }
            }
        }
    }
}
