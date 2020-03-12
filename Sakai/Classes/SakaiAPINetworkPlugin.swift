//
//  SakaiAPINetworkPlugin.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2020/03/12.
//

import Moya
import Result

final public class SakaiAPINetworkPlugin: PluginType {

    public init() {}

    public func willSend(_ request: RequestType, target: TargetType) {
        output(logNetworkRequest(request.request as URLRequest?))
    }

    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        // we only want to log requests
    }

    fileprivate func output(_ items: String) {
        debugPrint(items)
    }
}

extension SakaiAPINetworkPlugin {

    public func logNetworkRequest(_ request: URLRequest?) -> String {
        let method = request?.httpMethod ?? "???"
        let endpoint = request?.description ?? "(invalid request)"
        return "\(method)   \(endpoint)"
    }
}


