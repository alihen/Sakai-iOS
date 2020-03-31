//
//  ChatTests.swift
//  Tests
//
//  Created by Alastair Hendricks on 2020/03/31.
//

import Quick
import Nimble
import Sakai

class ChatTests: QuickSpec {

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

        describe("chat service") {
            it("can retrieve chat channels") {
                waitUntil(timeout: 20) { done in
                    SakaiAPIClient.shared.chat.getChatChannels(siteId: SakaiTestConfiguration.pass.siteId) { result in
                        expect(result.error).to(beNil())
                        expect(result.value).toNot(beNil())
                        expect(result.value?.collection).toNot(beEmpty())
                        done()
                    }
                }
            }
        }
    }
}

