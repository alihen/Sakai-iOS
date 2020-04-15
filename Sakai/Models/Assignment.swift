//
//  Assignment.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2020/04/08.
//

import Foundation

public struct SakaiAssignmentCollection: Decodable {
    public let collection: [SakaiAssignmentItem]

    enum CodingKeys: String, CodingKey {
        case collection = "assignment_collection"
    }
}

public struct SakaiAssignmentItem: Decodable {
    public let access: String?
    public let attachments: [SakaiAnnouncementAttachment]
    public let author: String
    public let authorLastModified: String?
    public let closeTime: SakaiAssignmentTime?
    public let closeTimeString: String?
    public let context: String?
    public let creator: String?
    public let dropDeadTime: SakaiAssignmentTime?
    public let dropDeadTimeString: String?
    public let dueTime: SakaiAssignmentTime?
    public let dueTimeString: String?
    public let id: String
    public let instructions: String?
    public let modelAnswerText: String?
    public let openTime: SakaiAssignmentTime?
    public let openTimeString: String?
    public let position: Int?
    public let section: String?
    public let status: String?
    public let submissionType: String?
    public let timeCreated: SakaiAssignmentTime?
    public let timeLastModified: SakaiAssignmentTime?
    public let title: String
    public let allowResubmission: Bool
    public let draft: Bool
    public let entityReference: String?
    public let entityURL: URL
    public let entityID: String
    public let entityTitle: String?

    enum CodingKeys: String, CodingKey {
        case access
        case attachments
        case author
        case authorLastModified
        case closeTime
        case closeTimeString
        case context
        case creator
        case dropDeadTime
        case dropDeadTimeString
        case dueTime
        case dueTimeString
        case id
        case instructions
        case modelAnswerText
        case openTime
        case openTimeString
        case position
        case section
        case status
        case submissionType
        case timeCreated
        case timeLastModified
        case title
        case allowResubmission
        case draft
        case entityReference
        case entityURL
        case entityID = "entityId"
        case entityTitle
    }
}

public struct SakaiAssignmentTime: Decodable {
    public let epochSecond: Int
    public let nano: Int
}
