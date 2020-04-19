//
//  UserProfile.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2020/03/29.
//

import Foundation

public struct SakaiUserProfile: Decodable {
    public let academicProfileURL: URL?
    public let birthday: String?
    public let birthdayDisplay: String?
    public let course: String?
    public let department: String?
    public let displayName: String?
    public let email: String?
    public let imageThumbURL: URL?
    public let imageURL: URL?
    public let mobilephone: String?
    public let position: String?
    public let universityProfileURL: URL?
    public let userUUID: String
    public let locked: Bool
    public let entityReference: String
    public let entityURL: URL
    public let entityID: String

    enum CodingKeys: String, CodingKey {
        case academicProfileURL = "academicProfileUrl"
        case birthday
        case birthdayDisplay
        case course
        case department
        case displayName
        case email
        case imageThumbURL = "imageThumbUrl"
        case imageURL = "imageUrl"
        case mobilephone
        case position
        case universityProfileURL = "universityProfileUrl"
        case userUUID = "userUuid"
        case locked
        case entityReference
        case entityURL
        case entityID = "entityId"
    }
}
