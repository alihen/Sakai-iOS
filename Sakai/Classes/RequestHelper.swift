//
//  RequestHelper.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2020/03/15.
//

import Foundation

class RequestHelper {
    class func getFrameworkVersion() -> String {
        return Bundle(for: RequestHelper.self).infoDictionary?["CFBundleShortVersionString"] as? String ?? "unknown"
    }
}
