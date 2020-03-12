//
//  SiteService.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2018/05/20.
//

import Foundation

public class SiteService {

    public func getSite(withID id: String, completion: @escaping NetworkServiceResponse<SakaiSite>) {
        SakaiAPIClient.shared.session.prepAuthedRoute { (sessionResult) in
            if let authError = sessionResult.error {
                completion(.failure(authError))
                return
            }

            sakaiProvider.request(.site(id)) { result in
                completion(ResponseHelper.handle(SakaiSite.self, result: result))
            }
        }
    }

    public func getAllSites(completion: @escaping NetworkServiceResponse<[SakaiSite]>) {
        SakaiAPIClient.shared.session.prepAuthedRoute { (sessionResult) in
            if let authError = sessionResult.error {
                completion(.failure(authError))
                return
            }
        }

        sakaiProvider.request(.sites) { result in
            switch result {
            case .success(let response):
                do {
                    let sitesCollection = try JSONDecoder().decode(SakaiSiteCollection.self, from: response.data)
                    let sites: [SakaiSite] = sitesCollection.collection.sorted{ $0.createdDate > $1.createdDate }
                    completion(.success(sites))
                    return
                } catch {
                    let error = SakaiError.init(kind: .parsing, localizedDescription: nil)
                    completion(.failure(error))
                    return
                }
            case .failure:
                let moyaErrors = SakaiError.parse(result: result)
                completion(.failure(moyaErrors))
                return
            }
        }
    }
}
