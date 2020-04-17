//
//  SakaiAPIClient.errors.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2020/04/17.
//

import Foundation

public protocol SakaiErrorReportingEngine: class {
    func logError(host: String, path: String, statusCode: Int?, errorPayload: [String: Any]?)
}

extension SakaiAPIClient {
    public func setReportingEngine(engine: SakaiErrorReportingEngine, force: Bool = false) {
        if errorReportingEngine == nil || force == true {
            errorReportingEngine = engine
        }
    }

    public func getReportingEngine() -> SakaiErrorReportingEngine? {
        return errorReportingEngine
    }

    internal func emitToReportingEngines(host: String, path: String, statusCode: Int?, errorPayload: [String: Any]?) {
        errorReportingEngine?.logError(host: host, path: path, statusCode: statusCode, errorPayload: errorPayload)
    }
}
