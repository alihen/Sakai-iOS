//
//  GradebookService.swift
//  Sakai
//
//  Created by Zachary Joseph Shyi-An Burk on 8/29/20.
//

import Foundation

public class GradebookService {

    public func getSiteGradebook(id: String, completion: @escaping NetworkServiceResponse<SakaiGradebook>) {
        SakaiAPIClient.shared.session.prepAuthedRoute { (sessionResult) in
            if let authError = sessionResult.error {
                completion(.failure(authError))
                return
            }

            sakaiProvider.request(.gradebook(id)) { result in
                completion(ResponseHelper.handle(SakaiGradebook.self, result: result))
            }
        }
    }
}

