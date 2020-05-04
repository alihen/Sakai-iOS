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

    public func getAllSitesViaPortal(completion: @escaping NetworkServiceResponse<[SakaiPortalSiteSection]>) {
        SakaiAPIClient.shared.session.prepAuthedRoute { (sessionResult) in
            if let authError = sessionResult.error {
                completion(.failure(authError))
                return
            }
        }

        guard
            let username = SakaiAPIClient.shared.username,
            let password = SakaiAPIClient.shared.password else {
                completion(.failure(SakaiError.init(kind: .unknown, localizedDescription: nil)))
                return
        }


        SakaiAPIClient.shared.session.legacyLoginUser(username: username, password: password) { loginResult in
            if loginResult.value == true {
                sakaiProvider.request(.sitesViaPortal) { result in
                    do {
                        guard let htmlString = try result.value?.mapString() else {
                            return
                        }
                        let sections = PortalHTMLParser.parsePortalHTML(
                            html: htmlString,
                            sectionSelector: "#otherSitesCategorWrap > div.moresites-left-col",
                            termSelector: "h3",
                            siteSelector: ".otherSitesCategorList > li",
                            dataSelector: "data-site-id")
                        completion(.success(sections))
                    }
                    catch {
                        completion(.failure(SakaiError.init(kind: .unknown, localizedDescription: error.localizedDescription)))
                    }
                }
            } else {
                completion(.failure(SakaiError.init(kind: .unknown, localizedDescription: "Unable to login via xlogin")))
            }
        }
    }

    public func getAllSitesViaDirect(completion: @escaping NetworkServiceResponse<[SakaiPortalSiteSection]>) {
        self.getAllSites { siteResult in
            if let error = siteResult.error {
                completion(.failure(error))
                return
            }

            let sites = siteResult.value ?? []
            var sectionSites: [SakaiPortalSite] = []
            for site in sites {
                let portalSite = SakaiPortalSite(id: site.id, title: site.title)
                sectionSites.append(portalSite)
            }
            let result = [SakaiPortalSiteSection(term: "All Sites", sites: sectionSites)]
            completion(.success(result))
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

    public func getSitePages(siteId: String, completion: @escaping NetworkServiceResponse<[SitePage]> ) {
        SakaiAPIClient.shared.session.prepAuthedRoute { (sessionResult) in
            if let authError = sessionResult.error {
                completion(.failure(authError))
                return
            }
        }

        sakaiProvider.request(.sitePages(siteId)) { result in
            completion(ResponseHelper.handle([SitePage].self, result: result))
        }
    }
}
