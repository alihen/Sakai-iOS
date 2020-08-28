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

    public static let syllabus = SakaiSyllabus(
        items: [
            SakaiSyllabusItem(
                attachments: [
                    SakaiSyllabusItemAttachment(
                        title: "DENT 207 PDM III -Syllabus- Summer 2020 -5-11-20.docx",
                        type: "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
                        url: "/access/content/attachment/468246f4-c2a7-460b-9a1b-0c1e0377a436/Syllabus/54d453e1-5955-442b-9eea-51d25773753a/DENT%20207%20PDM%20III%20-Syllabus-%20Summer%202020%20-5-11-20.docx"
                    ),
                ],
                data: "<p><br /></p>",
                endDate: 0,
                order: 1,
                startDate: 0,
                title: "DENT 207 Syllabus 2020"
            )
        ],
        redirectUrl: nil,
        siteId: "468246f4-c2a7-460b-9a1b-0c1e0377a436",
        entityReference: "/syllabus",
        entityURL: URL(string: "https://sakai.unc.edu/direct/syllabus")!,
        entityTitle: "site")
}

public struct SakaiSyllabusItem: Decodable {
    public let attachments: [SakaiSyllabusItemAttachment]
    public let data: String
    public let endDate: Int
    public let order: Int
    public let startDate: Int
    public let title: String
}

public struct SakaiSyllabusItemAttachment: Decodable {
    public let title: String
    public let type: String
    public let url: String
}
