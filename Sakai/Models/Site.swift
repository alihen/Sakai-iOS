//
//  Site.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2018/05/20.
//

import Foundation

public struct SakaiSiteCollection: Decodable {
    public let collection: [SakaiSite]

    enum CodingKeys: String, CodingKey {
        case collection = "site_collection"
    }
}

public struct SakaiSite: Decodable {
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
    public let maintainRole : String?
    public let modifiedDate : Int64
    //public let modifiedTime : [String : Any]?
    public let owner : String
    public let providerGroupId : String?
    public let pubView: Bool
    public let published : Bool
    public let reference : String?
    public let shortDescription : String?
    //public let siteGroups : [String : Any]?
    //publiclet siteOwner : [String : Any]?
    public let sitePages : [SitePage]?
    public let skin : String?
    public let softlyDeleted : Bool
    //public let softlyDeletedDate : Date?
    public let title : String
    public let type : String?
    public let userRoles : [String]?
    
    public static let portalSiteList = [
        SakaiPortalSiteSection(term: "Fall 2020", sites: [
            SakaiPortalSite(id: "e91cbf73-0320-4e5a-a789-35ae750894da", title: "DENT100.001.FA20"),
            SakaiPortalSite(id: "b4021848-bd0a-4f60-bb70-b192e23dad26", title: "DENT101.001.FA20"),
        ])
    ]
}

// A revised approach to handling Sites, using the Portal HTML
public struct SakaiPortalSiteSection: Decodable {
    public let term: String
    public let sites: [SakaiPortalSite]

    init(term: String, sites: [SakaiPortalSite]) {
        self.term = term
        self.sites = sites
    }
}

public struct SakaiPortalSite: Decodable {
    public let id: String
    public let title: String

    init(id: String, title: String) {
        self.id = id
        self.title = title
    }
}
