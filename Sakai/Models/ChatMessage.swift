//
//  ChatMessage.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2020/03/31.
//

import Foundation

public struct SakaiChatMessageCollection: Codable {
    public let collection: [SakaiChatMessage]

    enum CodingKeys: String, CodingKey {
        case collection = "chat-message_collection"
    }
}

public struct SakaiChatMessage: Codable {
    public let body: String
    public let chatChannelID: String
    public let context: String
    public let id: String
    public let messageDate: Int
    public let messageDateString: String?
    public let owner: String
    public let ownerDisplayID: String
    public let ownerDisplayName: String
    public let removeable: Bool
    public let entityReference: String
    public let entityURL: URL
    public let entityID: String
    public var avatarPath: String {
        get {
            return "/direct/profileClassic/\(owner)/image.jpg"
        }
    }

    enum CodingKeys: String, CodingKey {
        case body
        case chatChannelID = "chatChannelId"
        case context
        case id
        case messageDate
        case messageDateString
        case owner
        case ownerDisplayID = "ownerDisplayId"
        case ownerDisplayName
        case removeable
        case entityReference
        case entityURL
        case entityID = "entityId"
    }
}
