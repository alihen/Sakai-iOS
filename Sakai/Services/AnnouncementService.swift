//
//  AnnouncementService.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2018/05/20.
//

import Foundation

public class AnnouncementService {
    public func getAnnouncement(withID id: String, completion: @escaping NetworkServiceResponse<SakaiAnnouncement>) {
        SakaiAPIClient.shared.session.prepAuthedRoute { (sessionResult) in
            if let authError = sessionResult.error {
                completion(.failure(authError))
                return
            }

            sakaiProvider.request(.announcement(id)) { result in
                switch result {
                case .success(let response):
                    do {
                        let announcement: SakaiAnnouncement = try JSONDecoder().decode(SakaiAnnouncement.self, from: response.data)
                        self.getAnnouncementSiteTitles(announcements: [announcement], completion: { (titleResults) in
                            switch titleResults {
                            case .success(let finalAnnouncements):
                                guard let finalAnnouncement: SakaiAnnouncement = finalAnnouncements.first else {
                                    completion(.failure(SakaiError.init(kind: .unknown, localizedDescription: nil)))
                                    return
                                }

                                completion(.success(finalAnnouncement))
                                return
                            case .failure(let titleErrors):
                                completion(.failure(titleErrors))
                                return
                            }
                        })
                    } catch {
                        let error = SakaiError.parse(result: result)
                        completion(.failure(error))
                        return
                    }

                case .failure:
                    let sakaiError = SakaiError.parse(result: result)
                    completion(.failure(sakaiError))
                    return
                }
            }
        }
    }

    public func getRecentAnnouncements(completion: @escaping NetworkServiceResponse<[SakaiAnnouncement]>) {
        SakaiAPIClient.shared.session.prepAuthedRoute { (sessionResult) in
            if let authError = sessionResult.error {
                completion(.failure(authError))
                return
            }

            sakaiProvider.request(.announcementsUser("user")) { (result) in
                switch result {
                case .success(let response):
                    do {
                        let announcementCollection: SakaiAnnouncementCollection = try JSONDecoder().decode(SakaiAnnouncementCollection.self, from: response.data)
                        let announcements: [SakaiAnnouncement] = announcementCollection.collection.sorted(by: { $0.createdOn > $1.createdOn })
                        self.getAnnouncementSiteTitles(announcements: announcements, completion: { (titleResults) in
                            switch titleResults {
                            case .success(var finalAnnouncements):
                                finalAnnouncements = finalAnnouncements.map({
                                    var announcement: SakaiAnnouncement = $0
                                    announcement.body = announcement.body?.stripHTML()
                                    announcement.title = announcement.title?.trimmingCharacters(in: [" "])
                                    return announcement
                                })

                                completion(.success(finalAnnouncements))
                                return
                            case .failure:
                                let sakaiError = SakaiError.parse(result: result)
                                completion(.failure(sakaiError))
                                return
                            }
                        })
                    } catch {

                    }
                case .failure:
                    let sakaiError = SakaiError.parse(result: result)
                    completion(.failure(sakaiError))
                    return
                }
            }
        }
    }

    internal func getAnnouncementSiteTitles(announcements: [SakaiAnnouncement], completion: @escaping NetworkServiceResponse<[SakaiAnnouncement]>) {
        var newAnnouncements: [SakaiAnnouncement] = []
        for var announcement in announcements {
            sakaiProvider.request(.site(announcement.siteId), completion: { (result) in
                do {
                    let response = try result.get()
                    let site = try response.map(SakaiSite.self)
                    announcement.displaySiteTitle = site.title
                    newAnnouncements.append(announcement)

                    if announcements.count == newAnnouncements.count {
                        completion(.success(newAnnouncements))
                        return
                    }
                } catch {
                    let fail = SakaiError.parse(result: result)
                    completion(.failure(fail))
                    return
                }
            })
        }
    }
}
