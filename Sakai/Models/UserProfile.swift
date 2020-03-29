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
    public let dateOfBirth: String?
    public let department: String?
    public let displayName: String?
    public let email: String?
    public let imageThumbURL: URL?
    public let imageURL: URL?
    public let mobilephone: String?
    public let nickname: String?
    public let personalSummary: String?
    public let position: String?
    public let socialInfo: SakaiSocialInfo?
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
        case dateOfBirth
        case department
        case displayName
        case email
        case imageThumbURL = "imageThumbUrl"
        case imageURL = "imageUrl"
        case mobilephone
        case nickname
        case personalSummary
        case position
        case socialInfo
        case universityProfileURL = "universityProfileUrl"
        case userUUID = "userUuid"
        case locked
        case entityReference
        case entityURL
        case entityID = "entityId"
    }
}


public struct SakaiSocialInfo: Decodable {
    public let facebookURL: String?
    public let linkedinURL: String?
    public let myspaceURL: String?
    public let skypeUsername: String?
    public let twitterURL: String?
    public let userUUID: String

    enum CodingKeys: String, CodingKey {
        case facebookURL = "facebookUrl"
        case linkedinURL = "linkedinUrl"
        case myspaceURL = "myspaceUrl"
        case skypeUsername
        case twitterURL = "twitterUrl"
        case userUUID = "userUuid"
    }
}
