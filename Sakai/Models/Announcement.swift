//
//  Announcement.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2018/05/20.
//

import Foundation

public struct SakaiAnnouncementCollection: Codable {
    public let collection: [SakaiAnnouncement]

    enum CodingKeys: String, CodingKey {
        case collection = "announcement_collection"
    }
}

public struct SakaiAnnouncement: Codable {
    public let announcementId : String
    public let attachments : [SakaiAnnouncementAttachment]?
    public internal(set) var body : String?
    public let channel : String
    public let createdByDisplayName : String
    public let createdOn : Int64
    public let id : String
    public let siteId : String
    public let siteTitle : String?
    public internal(set) var title : String?
    public var displaySiteTitle: String?
}

public struct SakaiAnnouncementAttachment: Codable {
    public let id : String
    public let name : String
    public let ref : String?
    public let type : String?
    public let url : URL
}
