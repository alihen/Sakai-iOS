//
//  ResponseHelper.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2020/03/12.
//

import Moya
import Result

class ResponseHelper {

    class func handle<D: Decodable>(_ decode: D.Type, decoder: JSONDecoder = JSONDecoder(), result: Result<Moya.Response, MoyaError>, atKeyPath: String? = nil) -> Result<D, SakaiError> {
        do {
            // Throw if the status code is not in the 200-299 range, and let SakaiError.parse handle bubbling an error.
            let response = try result.get().filterSuccessfulStatusCodes()
            var output: D

            if let keyPath = atKeyPath {
                output = try response.map(decode, atKeyPath: keyPath, using: decoder)
            } else {
                output = try response.map(decode, using: decoder)
            }
            return .success(output)
        } catch let error as MoyaError {
            let customError: SakaiError = SakaiError.parse(result: result, additional: error)
            var errorType: String? = nil
            var errorPayload: [String: Any] = [:]
            switch error {
            case MoyaError.jsonMapping:
                errorType = "jsonMapping"
            case MoyaError.objectMapping(let swiftError as DecodingError, _):
                errorType = "objectMapping"
                errorPayload = ResponseHelper.getDecodingErrorContext(error: swiftError)
            case MoyaError.parameterEncoding:
                errorType = "parameterEncoding"
            case MoyaError.statusCode:
                errorType = "statusCode"
            default:
                errorType = "unknown"
            }

            errorPayload["moyaErrorType"] = errorType
            if
                let request = error.response?.request,
                let url = request.url,
                let host = url.host {
                SakaiAPIClient.shared.emitToReportingEngines(host: host, path: url.path, statusCode: error.response?.statusCode, errorPayload: errorPayload)
            }

            return .failure(customError)
        } catch {
            let customError: SakaiError = SakaiError.parse(result: result, additional: nil)
            return .failure(customError)
        }
    }

    class func getDecodingErrorContext(error: DecodingError) -> [String: Any] {
        var result: [String: Any] = [:]
        switch error {
        case .typeMismatch(let type, let context):
            result["decodingErrorType"] = "typeMismatch"
            result["MismatchType"] = String(describing: type.self)
            result["codingPath"] = context.codingPath.map({ $0.debugDescription })
            result["debugDescription"] = context.debugDescription
        case .keyNotFound(let key, let context):
            result["decodingErrorType"] = "keyNotFound"
            result["keyNotFound"] = key.stringValue
            result["codingPath"] = context.codingPath.map({ $0.debugDescription })
            result["debugDescription"] = context.debugDescription
        case .valueNotFound(let type, let context):
            result["decodingErrorType"] = "valueNotFound"
            result["valueType"] = String(describing: type.self)
            result["codingPath"] = context.codingPath.map({ $0.debugDescription })
            result["debugDescription"] = context.debugDescription
        default:
            break
        }
        return result
    }
}

