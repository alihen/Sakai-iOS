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

public let sakaiProvider = MoyaProvider<SakaiAPI>(plugins: [SakaiAPINetworkPlugin(), SakaiAPICachePlugin()])

public enum SakaiAPI {
    case legacyLogin(String, String)
    case session(String, String)
    case sessionCurrent

    case userCurrent

    case announcement(String)
    case announcementsSite(String)
    case announcementsUser(String)

    case sites
    case site(String)

    case contentSite(String)
    case contentMy
    case contentUser(String)
}

extension SakaiAPI: CachePolicyGettable {
    var cachePolicy: URLRequest.CachePolicy {
        return .reloadIgnoringLocalCacheData
    }
}

extension SakaiAPI: TargetType {
    public var headers: [String : String]? {
        switch self {
        case .legacyLogin:
            return [
                "Content-Type": "application/x-www-form-urlencoded",
                "Pragma": "no-cache",
                "User-Agent": "com.sakai.ios/\(RequestHelper.getFrameworkVersion())"]
        default:
            return [
            "Pragma": "no-cache",
            "User-Agent": "com.sakai.ios/\(RequestHelper.getFrameworkVersion())"]
        }
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
        case .legacyLogin:
            return "/portal/xlogin"
        case .session:
            return "/direct/session"
        case .sessionCurrent:
            return "/direct/session/current.json"

        case .userCurrent:
            return "/direct/user/current.json"

        case .announcement(let id):
            return "/direct/announcement/\(id).json"
        case .announcementsSite(let siteId):
            return "/direct/announcement/\(siteId).json"
        case .announcementsUser(let userId):
            return "/direct/announcement/\(userId).json"

        case .sites:
            return "/direct/site.json"
        case .site(let id):
            return "/direct/site/\(id).json"

        case .contentSite(let id):
            return "/direct/content/site/\(id).json"
        case .contentMy:
            return "/direct/content/my.json"
        case .contentUser(let eid): //Only admin type users will be able to view this content.
            return "/direct/content/user/\(eid).json"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .session, .legacyLogin:
            return .post
        default:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .legacyLogin(let username, let password):
            return .requestParameters(parameters: ["eid" : username, "pw" : password], encoding: URLEncoding.default)
        case .session(let username, let password):
            return .requestParameters(parameters: ["_username" : username, "_password" : password], encoding: URLEncoding.default)
        case .announcementsUser:
            return .requestParameters(parameters: ["n": "100", "d": "1000"], encoding: URLEncoding.default)
        case .sites:
            return .requestParameters(parameters: ["_limit": "300"], encoding: URLEncoding.default)
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
