//
//  SiteService.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2018/05/20.
//

import Foundation

public class SiteService {

    public func getSiteData(withID id: String, completion: @escaping (Result<Data>) -> Void) {
        Sakai.shared.session.prepAuthedRoute { (sessionResult) in
            if sessionResult.error != nil {
                completion(.failure(sessionResult.error!))
                return
            }

            sakaiProvider.request(.site(id)) { result in
                do {
                    let response = try result.dematerialize()
                    let data = response.data
                    completion(.success(data))
                    return
                } catch {
                    completion(.failure(error))
                    return
                }
            }
        }
    }


    public func getSite(withID id: String, completion: @escaping (Result<SakaiSite>) -> Void) {
        self.getSiteData(withID: id) { (result: Result<Data>) in
            switch result {
            case .success(let response):
                do {
                    let site = try JSONDecoder().decode(SakaiSite.self, from: response)
                    completion(.success(site))
                    return
                } catch {
                    completion(.failure(error))
                    return
                }
            case .failure(let error):
                completion(.failure(error))
                return
            }
        }
    }

    public func getAllSitesData(completion: @escaping (Result<Data>) -> Void) {
        Sakai.shared.session.prepAuthedRoute { (sessionResult) in
            if sessionResult.error != nil {
                completion(.failure(sessionResult.error!))
                return
            }
        }

        sakaiProvider.request(.sites) { result in
            do {
                let response = try result.dematerialize()
                let data = response.data
                completion(.success(data))
                return
            } catch {
                completion(.failure(error))
                return
            }
        }
    }

    public func getAllSites(completion: @escaping (Result<[SakaiSite]>) -> Void) {
        self.getAllSitesData { (result: Result<Data>) in
            switch result {
            case .success(let response):
                do {
                    let sitesCollection = try JSONDecoder().decode(SakaiSiteCollection.self, from: response)
                    let sites: [SakaiSite] = sitesCollection.collection.sorted{ $0.createdDate > $1.createdDate }
                    completion(.success(sites))
                    return
                } catch {
                    completion(.failure(error))
                    return
                }
            case .failure(let error):
                completion(.failure(error))
                return
            }
        }
    }
}
