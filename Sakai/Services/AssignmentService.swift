//
//  AssignmentService.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2020/04/08.
//

import Foundation

public class AssignmentService {

    public func getSiteAssignments(siteId: String, completion: @escaping NetworkServiceResponse<SakaiAssignmentCollection>) {
        SakaiAPIClient.shared.session.prepAuthedRoute { (sessionResult) in
            if let authError = sessionResult.error {
                completion(.failure(authError))
                return
            }

            sakaiProvider.request(.assignmentSite(siteId)) { result in
                completion(ResponseHelper.handle(SakaiAssignmentCollection.self, result: result))
            }
        }
    }

    public func getAssignmentItem(id: String, completion: @escaping NetworkServiceResponse<SakaiAssignmentItem>) {
        SakaiAPIClient.shared.session.prepAuthedRoute { (sessionResult) in
            if let authError = sessionResult.error {
                completion(.failure(authError))
                return
            }

            sakaiProvider.request(.assignmentItem(id)) { result in
                completion(ResponseHelper.handle(SakaiAssignmentItem.self, result: result))
            }
        }
    }

    public func getUserAssignments(completion: @escaping NetworkServiceResponse<SakaiAssignmentCollection>) {
        SakaiAPIClient.shared.session.prepAuthedRoute { (sessionResult) in
            if let authError = sessionResult.error {
                completion(.failure(authError))
                return
            }

            sakaiProvider.request(.assignmentMy) { result in
                completion(ResponseHelper.handle(SakaiAssignmentCollection.self, result: result))
            }
        }
    }
}
