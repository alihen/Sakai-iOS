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

public let sakaiProvider = MoyaProvider<SakaiAPI>(plugins: [SakaiAPINetworkPlugin()])

public enum SakaiAPI {
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

extension SakaiAPI: TargetType {
    public var headers: [String : String]? {
        return nil
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
            return "/session"
        case .sessionCurrent:
            return "/session/current.json"

        case .userCurrent:
            return "user/current.json"

        case .announcement(let id):
            return "/announcement/\(id).json"
        case .announcementsSite(let siteId):
            return "/announcement/\(siteId).json"
        case .announcementsUser(let userId):
            return "/announcement/\(userId).json"

        case .sites:
            return "/site.json"
        case .site(let id):
            return "/site/\(id).json"

        case .contentSite(let id):
            return "/content/site/\(id).json"
        case .contentMy:
            return "/content/my.json"
        case .contentUser(let eid): //Only admin type users will be able to view this content.
            return "/content/user/\(eid).json"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .session:
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
            return .requestParameters(parameters: ["n": "20", "d": "1000"], encoding: URLEncoding.default)
        case .sites:
            return .requestParameters(parameters: ["_limit": "100"], encoding: URLEncoding.default)
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
