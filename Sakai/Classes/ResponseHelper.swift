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
        } catch let error as MoyaError where error is MoyaError {
            let customError: SakaiError = SakaiError.parse(result: result, additional: error)
            return .failure(customError)
        } catch {
            let customError: SakaiError = SakaiError.parse(result: result, additional: nil)
            return .failure(customError)
        }
    }
}

