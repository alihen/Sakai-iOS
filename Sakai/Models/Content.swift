//
//  Content.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2018/05/20.
//

import Foundation

public struct SakaiContentCollection: Decodable {
    public let contentCollection: [SakaiContent]

    enum CodingKeys: String, CodingKey {
        case contentCollection = "content_collection"
    }
}

public struct SakaiContent: Decodable {
    public let created: Int
    public let creator: String?
    public let description: String?
    public let hidden: Bool
    public let mimeType: String?
    public let modified: Int?
    public let modifiedBy: String?
    public let name: String
    public let priority: String?
    public let reference: String
    public let resourceChildren: [SakaiContent]
    public let resourceID: String?
    public let size: String?
    public let type: String?
    public let url: URL

    enum CodingKeys: String, CodingKey {
        case created
        case creator
        case description
        case hidden
        case mimeType
        case modified
        case modifiedBy
        case name
        case priority
        case reference
        case resourceChildren
        case resourceID = "resourceId"
        case size
        case type
        case url
    }
}
