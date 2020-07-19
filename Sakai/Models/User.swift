//
//  User.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2018/05/20.
//

import Foundation

public struct SakaiUser: Codable {
    public let displayName: String?
    public let email: String?
    public let eid : String?
    public let id : String
}
