//
//  SakaiProvider.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2018/05/20.
//

import Foundation
import Moya

private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

public var sakaiProvider = MoyaProvider<SakaiAPI>(manager: SakaiAPIAlamofireManager.sharedManager, plugins: [SakaiAPINetworkPlugin(), SakaiAPICachePlugin()])

public enum SakaiAPI {
    case session(String, String)
    case legacyLogin(String, String)
    case sessionCurrent
    case userCurrent
    case userProfile(String)
    case announcement(String)
    case announcementsSite(String)
    case announcementsUser(String)
    case sites
    case sitesViaPortal
    case site(String)
    case sitePages(String)
    case contentSite(String, String?) // Site ID, Path
    case contentMy
    case contentUser(String)
    case chatChannels(String) // Site ID
    case chatMessages(String) // Channel ID
    case postChatMessage(String, String) // Channel ID, Body
    case calendarSite(String)
    case calendarEvent(String, String) // Site ID, Event ID
    case calendarMy
    case assignmentSite(String)
    case assignmentItem(String)
    case assignmentMy
}

extension SakaiAPI: CachePolicyGettable {
    public var cachePolicy: URLRequest.CachePolicy {
        switch self {
        case .sites, .site:
            return .reloadRevalidatingCacheData
        default:
            return .reloadIgnoringLocalAndRemoteCacheData
        }
    }
}

extension SakaiAPI: TargetType {
    public var headers: [String : String]? {
        return [
        "User-Agent": "com.sakai.ios/\(RequestHelper.getFrameworkVersion())"]
    }

    public var baseURL: URL {
        guard let url: URL = SakaiAPIClient.shared.baseURL else {
            assertionFailure("Please define the base URL by providing the Sakai instance with a configuration.")
            return URL(string: "")!
        }

        return url
    }

    public var path: String {
        switch self {
        case .session:
            return "/direct/session"
        case .legacyLogin:
            return "/portal/xlogin"
        case .sessionCurrent:
            return "/direct/session/current.json"
        case .userCurrent:
            return "/direct/user/current.json"
        case .userProfile(let uid):
            return "/direct/profile/\(uid).json"
        case .announcement(let id):
            return "/direct/announcement/\(id).json"
        case .announcementsSite(let siteId):
            return "/direct/announcement/site/\(siteId).json"
        case .announcementsUser(let userId):
            return "/direct/announcement/\(userId).json"
        case .sitesViaPortal:
            return "/portal"
        case .sites:
            return "/direct/site.json"
        case .site(let id):
            return "/direct/site/\(id).json"
        case .sitePages(let id):
            return "/direct/site/\(id)/pages.json"
        case .contentSite(let id, let path):
            if let path = path {
                return "/direct/content/resources/\(id)/\(path).json"
            }
            return "/direct/content/resources/\(id).json"
        case .contentMy:
            return "/direct/content/my.json"
        case .contentUser(let eid): //Only admin type users will be able to view this content.
            return "/direct/content/user/\(eid).json"
        case .chatChannels:
            return "/direct/chat-channel.json"
        case .chatMessages:
            return "/direct/chat-message.json"
        case .postChatMessage:
            return "/direct/chat-message/new"
        case .calendarSite(let siteId):
            return "/direct/calendar/site/\(siteId).json"
        case .calendarEvent(let siteId, let eventId):
            return "/direct/calendar/event/\(siteId)/\(eventId).json"
        case .calendarMy:
            return "/direct/calendar/my.json"
        case .assignmentSite(let siteId):
            return "/direct/assignment/site/\(siteId).json"
        case .assignmentItem(let assignmentId):
            return "/direct/assignment/item/\(assignmentId).json"
        case .assignmentMy:
            return "/direct/assignment/my.json"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .session, .postChatMessage, .legacyLogin:
            return .post
        default:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .session(let username, let password):
            return .requestParameters(parameters: ["_username" : username, "_password" : password], encoding: URLEncoding.default)
        case .announcementsUser:
            return .requestParameters(parameters: ["n": "30", "d": "90"], encoding: URLEncoding.default)
        case .legacyLogin(let username, let password):
            return .requestParameters(parameters: ["eid" : username, "pw" : password], encoding: URLEncoding.httpBody)
        case .sites:
            return .requestParameters(parameters: ["_limit": "40"], encoding: URLEncoding.default)
        case .chatChannels(let siteId):
            return .requestParameters(parameters: ["siteId": siteId], encoding: URLEncoding.default)
        case .chatMessages(let channelId):
            return .requestParameters(parameters: ["channelId": channelId, "items": "1000"], encoding: URLEncoding.default)
        case .postChatMessage(let channelId, let body):
            return .requestParameters(parameters: ["chatChannelId": channelId, "body": body], encoding: URLEncoding.default)
        default:
            return .requestPlain
        }

    }

    public var validate: Bool {
        return true
    }

    public var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
}
