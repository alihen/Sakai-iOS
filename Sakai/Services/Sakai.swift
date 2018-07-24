//
//  Sakai.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2018/05/20.
//

import Foundation

final public class Sakai: NSObject {

    public let announcements: AnnouncementService = AnnouncementService()
    public let session: SessionService = SessionService()
    public let site: SiteService = SiteService()
    public internal(set) var loggedInUserSession: SakaiSession?

    internal var username: String? = nil
    internal var password: String? = nil
    internal var baseURL: URL? = nil

    public class var shared: Sakai {
        struct Static {
            static let instance: Sakai = Sakai()
        }
        return Static.instance
    }

    public override init() {
        super.init()
    }

    public func start(configuration: SakaiConfiguration, username: String, password: String) {
        self.baseURL = configuration.baseURL
        self.username = username
        self.password = password
    }

    public func ensureUserIsAuthorized() -> Bool {
        guard let session: SakaiSession = loggedInUserSession else {
            return false
        }
        let currentTimestamp = Time.getCurrentTimestamp()
        let lastRefreshed = session.lastAccessedTime/1000

        let timeElapsed = currentTimestamp-lastRefreshed

        if timeElapsed >= 600  {
            return false
        }

        return true
    }
}

