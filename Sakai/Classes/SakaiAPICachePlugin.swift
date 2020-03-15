//
//  SakaiAPICachePlugin.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2020/03/15.
//

import Foundation
import Moya

protocol CachePolicyGettable {
    var cachePolicy: URLRequest.CachePolicy { get }
}

final class SakaiAPICachePlugin: PluginType {

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        if let cacheableTarget = target as? CachePolicyGettable {
            var mutableRequest = request
            mutableRequest.cachePolicy = cacheableTarget.cachePolicy
            return mutableRequest
        }
        return request
    }
}
