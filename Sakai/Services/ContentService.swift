//
//  ContentService.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2020/03/21.
//

import Foundation

public class ContentService {

    public func getResources(withID id: String, path: String?, completion: @escaping NetworkServiceResponse<SakaiContentCollection>) {
        SakaiAPIClient.shared.session.prepAuthedRoute { (sessionResult) in
            if let authError = sessionResult.error {
                completion(.failure(authError))
                return
            }

            sakaiProvider.request(.contentSite(id, path)) { result in
                completion(ResponseHelper.handle(SakaiContentCollection.self, result: result))
            }
        }
    }
}
