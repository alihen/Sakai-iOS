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
            if (SakaiTestConfiguration.pass.baseURL.absoluteString == "1" || SakaiTestConfiguration.pass.chatChannelId == "1") {
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

            it("can retrieve chat messages for a channel") {
                waitUntil(timeout: 20) { done in
                    SakaiAPIClient.shared.chat.getChatMessages(channelId: SakaiTestConfiguration.pass.chatChannelId) { result in
                        expect(result.error).to(beNil())
                        expect(result.value).toNot(beNil())
                        expect(result.value?.collection).toNot(beEmpty())
                        guard let chatMessage = result.value?.collection.first else {
                            fail("Unable to get chat message")
                            done()
                            return
                        }

                        expect(chatMessage.avatarPath).to(equal("/direct/profile/\(chatMessage.owner)/image.jpg"))
                        done()
                    }
                }
            }
        }
    }
}

