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
    public let context: String?
    public let description: String?
    public let id: String
    public let placement: String?
    public let title: String
    public let defaultForContext: Bool
    public let entityReference: String?
    public let entityURL: URL
    public let entityID: String
    public let entityTitle: String?

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
