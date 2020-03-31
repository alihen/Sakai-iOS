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
    let body: String
    let chatChannelID: String
    let context: String
    let id: String
    let messageDate: Int
    let messageDateString: String?
    let owner: String
    let ownerDisplayID: String
    let ownerDisplayName: String
    let removeable: Bool
    let entityReference: String
    let entityURL: URL
    let entityID: String

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
