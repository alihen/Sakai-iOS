//
//  WebContentService.swift
//  Sakai
//
//  Created by Zachary Joseph Shyi-An Burk on 8/28/20.
//

import Foundation

public class WebContentService {

    public func getSiteWebContent(id: String, completion: @escaping NetworkServiceResponse<[SakaiWebContent]>) {
        SakaiAPIClient.shared.session.prepAuthedRoute { (sessionResult) in
            if let authError = sessionResult.error {
                completion(.failure(authError))
                return
            }

            sakaiProvider.request(.webContent(id)) { result in
                let result = ResponseHelper.handle([SakaiWebContent].self, result: result, atKeyPath: "webcontent_collection")

                guard let webContent: [SakaiWebContent] = result.value else {
                    completion(result)
                    return
                }

                completion(.success(webContent))
                return
            }
        }
    }
}

