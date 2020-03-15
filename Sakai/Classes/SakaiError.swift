//
//  SakaiError.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2020/03/12.
//

import Foundation
import Moya
import Result

public struct SakaiError: Error {
    public enum Kind: String {
        case server
        case client
        case parsing
        case unknown
    }

    public let kind: SakaiError.Kind
    public let code: Int?
    public let localizedDescription: String?
    public let title: String?
    public let message: String?

    public init(kind: SakaiError.Kind, code: Int? = nil, localizedDescription: String?, title: String? = nil, message: String? = nil) {
        self.kind = kind
        self.code = code
        self.localizedDescription = localizedDescription
        self.title = title
        self.message = message
    }

    public static func parse(result: Result<Moya.Response, MoyaError>, additional: MoyaError? = nil) -> SakaiError {
        var error: SakaiError

        guard let statusCode = result.value?.statusCode else {
            error = SakaiError(kind: .unknown, code: 0, localizedDescription: result.error?.localizedDescription)
            return error
        }

        let title = "An error occurred"
        let message = result.error?.errorDescription

        switch statusCode {
        case 200..<300:
            guard let moyaError: MoyaError = additional  else {
                error = SakaiError(kind: .unknown, code: statusCode, localizedDescription: nil, title: title, message: message)
                return error
            }

            switch moyaError {
            case MoyaError.objectMapping:
                error = SakaiError(kind: .parsing, code: statusCode, localizedDescription: moyaError.localizedDescription, title: title, message: message)
            default:
                error = SakaiError(kind: .unknown, code: statusCode, localizedDescription: nil, title: title, message: message)
                break
            }


        case 400..<500:
            error = SakaiError(kind: .client, code: statusCode, localizedDescription: result.error?.localizedDescription, title: title, message: message)
        case 500..<511:
            error = SakaiError(kind: .server, code: statusCode, localizedDescription: result.error?.localizedDescription, title: title, message: message)
        default:
            error = SakaiError(kind: .unknown, code: statusCode, localizedDescription: result.error?.localizedDescription, title: title, message: message)
        }

        return error
    }
}
