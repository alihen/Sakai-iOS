//
//  SakaiGradebook.swift
//  Sakai
//
//  Created by Zachary Joseph Shyi-An Burk on 8/29/20.
//

import Foundation

public struct SakaiGradebook: Codable {
    public let assignments: [SakaiGradebookAssignment]
    public let siteId: String
    public let siteName: String
    public let entityReference: String
    public let entityURL: String
    public let entityTitle: String
    
    public static let gradebook = SakaiGradebook(
        assignments: [
            SakaiGradebookAssignment(
                grade: "90.00",
                itemName: "Exam 1",
                points: 100,
                userId: "2cab5dd1-337d-4a8f-ab2e-b77228c45f25",
                userName: "Zachary Burk"
            )
        ],
        siteId: "883e3c03-217a-4ead-b6e4-75f43134466f",
        siteName: "DENT205.001.FA20",
        entityReference: "/gradebook",
        entityURL: "https://sakai.unc.edu/direct/gradebook",
        entityTitle: "site"
    )
}

public struct SakaiGradebookAssignment: Codable {
    public let grade: String
    public let itemName: String
    public let points: Int
    public let userId: String
    public let userName: String
}
