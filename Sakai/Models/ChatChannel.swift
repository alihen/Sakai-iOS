//
//  ChatChannel.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2020/03/31.
//

import Foundation

public struct SakaiChatChannelCollection: Codable {
    public let collection: [SakaiChatChannel]

    enum CodingKeys: String, CodingKey {
        case collection = "chat-channel_collection"
    }
}

public struct SakaiChatChannel: Codable {
    let context: String
    let description: String?
    let id: String
    let placement: String?
    let title: String
    let defaultForContext: Bool
    let entityReference: String
    let entityURL: URL
    let entityID: String
    let entityTitle: String

    enum CodingKeys: String, CodingKey {
        case context
        case description
        case id
        case placement
        case title
        case defaultForContext
        case entityReference
        case entityURL
        case entityID = "entityId"
        case entityTitle
    }
}
