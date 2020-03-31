//
//  Calendar.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2020/03/31.
//

import Foundation

public struct SakaiCalendarCollection: Codable {
    public let collection: [SakaiCalendarItem]

    enum CodingKeys: String, CodingKey {
        case collection = "calendar_collection"
    }
}

public struct SakaiCalendarItem: Codable {
    public let assignmentID: String?
    public let attachments: [SakaiAnnouncementAttachment]?
    public let creator: String
    public let description: String
    public let descriptionFormatted: String?
    public let duration: Int
    public let eventIcon: String?
    public let eventID: String
    public let firstTime: SakaiCalendarEvent
    public let lastTime: SakaiCalendarEvent?
    public let location: String?
    public let recurrenceRule: SakaiCalendarRecurrenceRule?
    public let reference: String
    public let siteID: String
    public let siteName: String
    public let title: String
    public let type: String
    public let entityReference: String
    public let entityURL: URL
    public let entityTitle: String

    enum CodingKeys: String, CodingKey {
        case assignmentID = "assignmentId"
        case attachments
        case creator
        case description
        case descriptionFormatted
        case duration
        case eventIcon
        case eventID = "eventId"
        case firstTime
        case lastTime
        case location
        case recurrenceRule
        case reference
        case siteID = "siteId"
        case siteName
        case title
        case type
        case entityReference
        case entityURL
        case entityTitle
    }
}

public struct SakaiCalendarEvent: Codable {
    public let display: String
    public let time: Int
}

public struct SakaiCalendarRecurrenceRule: Codable {
    public let count: Int
    public let frequency: String
    public let frequencyDescription: String
    public let interval: Int
    public let until: SakaiCalendarEvent?
}
