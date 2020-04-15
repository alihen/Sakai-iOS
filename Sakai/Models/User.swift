//
//  User.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2018/05/20.
//

import Foundation

public struct SakaiUser: Codable {
    public let firstName: String?
    public let lastName: String?
    public let email: String?
    public let userEid : String
    public let userId : String
    public let type: String?
}
