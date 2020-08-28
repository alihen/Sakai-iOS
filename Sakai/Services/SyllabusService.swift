
//
//  SyllabusService.swift
//  Sakai
//
//  Created by Zachary Joseph Shyi-An Burk on 8/28/20.
//

import Foundation

public class SyllabusService {

    public func getSiteSyllabus(id: String, completion: @escaping NetworkServiceResponse<SakaiSyllabus>) {
        SakaiAPIClient.shared.session.prepAuthedRoute { (sessionResult) in
            if let authError = sessionResult.error {
                completion(.failure(authError))
                return
            }

            sakaiProvider.request(.syllabus(id)) { result in
                let result = ResponseHelper.handle(SakaiSyllabus.self, result: result)

                guard let syllabus: SakaiSyllabus = result.value else {
                    completion(result)
                    return
                }

                completion(.success(syllabus))
                return
            }
        }
    }
}

