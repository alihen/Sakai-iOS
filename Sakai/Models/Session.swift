//
//  Session.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2018/05/20.
//

import Foundation

public struct SakaiSession: Codable {
    public let active : Bool
    public let creationTime : Int64
    public let currentTime : Int64
    public let id : String?
    public let lastAccessedTime : Int64
    public let maxInactiveInterval : Int?
    public let userEid : String
    public let userId : String
}

