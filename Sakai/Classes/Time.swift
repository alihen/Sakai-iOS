//
//  Time.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2018/05/20.
//
import Foundation

final public class Time {

	public class func getCurrentTimestamp() -> Int64 {
		return Int64(Date().timeIntervalSince1970)
	}
}
