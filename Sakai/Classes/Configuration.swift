//
//  Configuration.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2018/05/20.
//

import Foundation

public struct SakaiConfiguration {
    public let baseURL: URL

    public init(baseURL: URL){
        self.baseURL = baseURL
    }
}
