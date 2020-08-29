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
    public internal(set) var strippedBody : String?
    public let channel : String
    public let createdByDisplayName : String
    public let createdOn : Int64
    public let id : String
    public let siteId : String
    public let siteTitle : String?
    public internal(set) var title : String?
    public var displaySiteTitle: String?
    
    public static let announcementList = [
        SakaiAnnouncement(
            announcementId: "e91cbf73-0320-4e5a-a789-35ae750894da",
            attachments: [SakaiAnnouncementAttachment](),
            body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus commodo metus sit amet dolor sodales faucibus. Praesent vitae odio scelerisque, imperdiet libero et, luctus ex. Nullam nibh enim, ultrices vitae felis nec, tristique pharetra leo. Vivamus blandit nisi vitae nisi pretium, id gravida dolor blandit.",
            strippedBody: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus commodo metus sit amet dolor sodales faucibus. Praesent vitae odio scelerisque, imperdiet libero et, luctus ex. Nullam nibh enim, ultrices vitae felis nec, tristique pharetra leo. Vivamus blandit nisi vitae nisi pretium, id gravida dolor blandit.",
            channel: "b4021848-bd0a-4f60-bb70-b192e23dad26",
            createdByDisplayName: "User 1",
            createdOn: 1598633248537,
            id: "0e4eb233-1caf-4bc0-8b9d-173e0e16238c",
            siteId: "e91cbf73-0320-4e5a-a789-35ae750894da",
            siteTitle: "",
            title: "Suspendisse tortor"
        ),
        SakaiAnnouncement(
            announcementId: "c4d4b1b1-3044-4665-a4e6-b4f51813c193",
            attachments: [SakaiAnnouncementAttachment](),
            body: "Duis pharetra sapien non ante venenatis, ultrices euismod nibh rhoncus. Sed ante nisi, egestas sed est quis, faucibus vestibulum elit. Suspendisse tincidunt id metus id dignissim. In ut vulputate mauris. Vivamus facilisis gravida tortor tempor fermentum. Aenean hendrerit magna et elit hendrerit, in porttitor arcu dapibus. Vivamus condimentum nunc sed enim rhoncus, ullamcorper pulvinar purus elementum.",
            strippedBody: "Duis pharetra sapien non ante venenatis, ultrices euismod nibh rhoncus. Sed ante nisi, egestas sed est quis, faucibus vestibulum elit. Suspendisse tincidunt id metus id dignissim. In ut vulputate mauris. Vivamus facilisis gravida tortor tempor fermentum. Aenean hendrerit magna et elit hendrerit, in porttitor arcu dapibus. Vivamus condimentum nunc sed enim rhoncus, ullamcorper pulvinar purus elementum.",
            channel: "b4021848-bd0a-4f60-bb70-b192e23dad26",
            createdByDisplayName: "User 1",
            createdOn: 1598633248537,
            id: "649ca16c-63b3-44a9-866f-7f4ba356b7fc",
            siteId: "e91cbf73-0320-4e5a-a789-35ae750894da",
            siteTitle: "",
            title: "Lorem Ipsum"
        )
    ]
}

public struct SakaiAnnouncementAttachment: Codable {
    public let id : String
    public let name : String
    public let ref : String?
    public let type : String?
    public let url : URL
}
