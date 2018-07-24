//
//  Result.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2018/05/20.
//

import Foundation

/// Result enumeration to handle data which need to be provided
///
/// - success: When a operation is successfull you can give the state success witch a result object <GenericType>
/// - failure: When a operation has failed you can give a failure state with a error which conform the error protocol
public enum Result<T> {
	case success(T)
	case failure(Error)

	public var isSuccess: Bool {
		switch self {
		case .success:
			return true
		case .failure:
			return false
		}
	}

	public var isFailure: Bool {
		return !isSuccess
	}

	public var error: Error? {
		switch self {
		case .success:
			return nil
		case .failure(let error):
			return error
		}
	}

	public var result: T? {
		switch self {
		case .success(let result):
			return result
		case .failure:
			return nil
		}
	}
}
