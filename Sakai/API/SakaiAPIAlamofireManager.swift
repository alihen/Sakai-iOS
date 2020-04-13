//
//  SakaiAPIAlamofireManager.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2020/04/13.
//

import Foundation
import Alamofire

final public class SakaiAPIAlamofireManager: Alamofire.SessionManager {
    static let sharedManager: SakaiAPIAlamofireManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 20
        configuration.timeoutIntervalForResource = 20
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return SakaiAPIAlamofireManager(configuration: configuration)
    }()
}
