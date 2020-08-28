//
//  Syllabus.swift
//  Sakai
//
//  Created by Zachary Joseph Shyi-An Burk on 8/28/20.
//

import Foundation

public struct SakaiSyllabus: Decodable {
    public let items: [SakaiSyllabusItem]
    public let redirectUrl: URL?
    public let siteId: String
    public let entityReference: String
    public let entityURL: URL
    public let entityTitle: String
}

public struct SakaiSyllabusItem: Decodable {
    public let attachments: [SakaiSyllabusItemAttachment] = []
    public let data: String
    public let endDate: Bool
    public let order: Int
    public let startDate: Bool
    public let title: String
}

public struct SakaiSyllabusItemAttachment: Decodable {
}
