//
//  SitePage.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2020/03/15.
//

import Foundation

public struct SitePage: Decodable {
    public let id: String
    public let siteID: String
    public let position: Int?
    public let url: URL
    public let title: String?
    public let skin: String?
    public let layoutTitle: String?
    public let tools: [SitePageTool]?

    enum CodingKeys: String, CodingKey {
        case id
        case siteID = "siteId"
        case position
        case url
        case title
        case skin
        case layoutTitle
        case tools
    }
}

public struct SitePageTool: Decodable {
    public let toolId: String?
    public let pageOrder: Int?
    public let siteId: String?
    public let id: String
    public let title: String?
    public let pageId: String?
    public let url : URL?
    public var toolPath: String {
        get {
            return "/portal/tool-reset/\(id)"
        }
    }

    enum CodingKeys: String, CodingKey {
        case toolId
        case pageOrder
        case siteId
        case id
        case title
        case pageId
        case url
    }
}
