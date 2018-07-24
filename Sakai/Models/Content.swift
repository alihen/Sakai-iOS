//
//  Content.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2018/05/20.
//

import Foundation

public struct SakaiContentCollection: Codable {
    public let collection: [SakaiSite]
}

public struct SakaiContent: Codable {
    public let author : String
    public let authorId : String
    public let container : String
    public let copyrightAlert : String?
    public let description : String?
    public let endDate : Date?
    public let fromDate : Date?
    public let modifiedDate : Date
    public let numChildren : Int
    public let quota : String?
    public let size : Int64
    public let title : String
    public let type : String
    public let url : URL
    public let usage : String?
    public let hidden : Bool
    public let visible : Bool
    public let entityReference : String
    public let entityURL : URL
    public let entityTitle : String
}
