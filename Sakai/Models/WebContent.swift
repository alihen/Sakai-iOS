//
//  SakaiWebContent.swift
//  Sakai
//
//  Created by Zachary Joseph Shyi-An Burk on 8/28/20.
//

import Foundation

public struct SakaiWebContent: Decodable {
    public let title: String
    public let url: String
    public let entityReference: String
    public let entityURL: String
    public let entityTitle: String
}
