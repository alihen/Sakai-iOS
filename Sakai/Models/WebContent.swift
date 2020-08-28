//
//  SakaiWebContent.swift
//  Sakai
//
//  Created by Zachary Joseph Shyi-An Burk on 8/28/20.
//

import Foundation

public struct SakaiWebContent: Decodable {
    var title: String
    var url: String
    var entityReference: String
    var entityURL: String
    var entityTitle: String
}
