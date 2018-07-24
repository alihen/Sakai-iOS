//
//  Site.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2018/05/20.
//

import Foundation

public struct SakaiSiteCollection: Codable {
    public let collection: [SakaiSite]

    enum CodingKeys: String, CodingKey {
        case collection = "site_collection"
    }
}

public struct SakaiSite: Codable {
    public let activeEdit : Bool
    public let contactEmail : String?
    public let contactName : String?
    public let createdDate : Date
    //public let createdTime : [String : Any]?
    public let customPageOrdered : Bool
    public let description : String?
    public let empty : Bool
    public let htmlDescription : String?
    public let htmlShortDescription : String?
    public let iconUrl : String?
    public let iconFullUrl : URL?
    public let id : String
    public let infoUrl : String?
    public let infoFullUrl : URL?
    public let joinable : Bool
    public let joinerRole : String?
    public let lastModified : Int64
    public let maintainRole : String
    public let modifiedDate : Int64
    //public let modifiedTime : [String : Any]?
    public let owner : String
    public let providerGroupId : String?
    public let pubView: Bool
    public let published : Bool
    public let reference : String
    public let shortDescription : String?
    //public let siteGroups : [String : Any]?
    //publiclet siteOwner : [String : Any]?
    //public let sitePages : [String: String]
    public let skin : String?
    public let softlyDeleted : Bool
    //public let softlyDeletedDate : Date?
    public let title : String
    public let type : String
    public let userRoles : [String]
}
