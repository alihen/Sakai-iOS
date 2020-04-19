//
//  SakaiAPICachePlugin.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2020/03/15.
//

import Foundation
import Moya

public protocol CachePolicyGettable {
    var cachePolicy: URLRequest.CachePolicy { get }
}

final public  class SakaiAPICachePlugin: PluginType {

    public init() {}

    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        if let cacheableTarget = target as? CachePolicyGettable {
            var mutableRequest = request
            mutableRequest.cachePolicy = cacheableTarget.cachePolicy
            return mutableRequest
        }
        return request
    }
}
