//
//  SitePage.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2020/03/15.
//

import Foundation

public struct SitePage: Decodable {
    public let id: String
    public let layout: Int?
    public let activeEdit: Bool
    public let siteID: String
    public let position: Int?
    public let popUp: Bool?
    public let homePage: Bool?
    public let url: URL
    public let title: String
    public let skin: String?
    public let layoutTitle: String?
    public let reference: String?
    public let titleCustom: Bool?
    public var pagePath: String {
        get {
            return "/portal/page/\(id)"
        }
    }

    enum CodingKeys: String, CodingKey {
        case id
        case layout
        case activeEdit
        case siteID = "siteId"
        case position
        case popUp
        case homePage
        case url
        case title
        case skin
        case layoutTitle
        case reference
        case titleCustom
    }
}
