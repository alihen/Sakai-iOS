//
//  AnnouncementService.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2018/05/20.
//

import Foundation

public class AnnouncementService {
    public func getAnnouncementData(withID id: String, completion: @escaping (Result<Data>) -> Void) {
        Sakai.shared.session.prepAuthedRoute { (sessionResult) in
            if sessionResult.error != nil {
                completion(.failure(sessionResult.error!))
                return
            }

            sakaiProvider.request(.announcement(id)) { result in
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

    public func getAnnouncement(withID id: String, completion: @escaping (Result<SakaiAnnouncement>) -> Void) {
        self.getAnnouncementData(withID: id) { (result: Result<Data>) in
            switch result {
            case .success(let response):
                do {
                    let announcement: SakaiAnnouncement = try JSONDecoder().decode(SakaiAnnouncement.self, from: response)
                    self.getAnnouncementSiteTitles(announcements: [announcement], completion: { (titleResults) in
                        switch titleResults {
                        case .success(let finalAnnouncements):
                            guard let finalAnnouncement: SakaiAnnouncement = finalAnnouncements.first else {
                                completion(.failure(NSError()))
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
                    completion(.failure(error))
                    return
                }

            case .failure(let error):
                completion(.failure(error))
                return
            }
        }
    }

    public func getRecentAnnouncementsData(completion: @escaping (Result<Data>) -> Void) {
        Sakai.shared.session.prepAuthedRoute { (sessionResult) in
            if sessionResult.error != nil {
                completion(.failure(sessionResult.error!))
                return
            }

            sakaiProvider.request(.announcementsUser("user")) { (result) in
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

    public func getRecentAnnouncements(completion: @escaping (Result<[SakaiAnnouncement]>) -> Void) {
        self.getRecentAnnouncementsData { (result: Result<Data>) in
            switch result {
            case .success(let response):
                do {
                    let announcementCollection: SakaiAnnouncementCollection = try JSONDecoder().decode(SakaiAnnouncementCollection.self, from: response)
                    let announcements: [SakaiAnnouncement] = announcementCollection.collection
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
                        case .failure(let titleErrors):
                            completion(.failure(titleErrors))
                            return
                        }
                    })
                } catch {

                }
            case .failure(let error):
                completion(.failure(error))
                return
            }
        }
    }

    internal func getAnnouncementSiteTitles(announcements: [SakaiAnnouncement], completion: @escaping (Result<[SakaiAnnouncement]>) -> Void) {
        var newAnnouncements: [SakaiAnnouncement] = []
        for var announcement in announcements {
            sakaiProvider.request(.site(announcement.siteId), completion: { (result) in
                do {
                    let response = try result.dematerialize()
                    let site = try response.map(SakaiSite.self)
                    announcement.displaySiteTitle = site.title
                    newAnnouncements.append(announcement)

                    if announcements.count == newAnnouncements.count {
                        completion(.success(newAnnouncements))
                        return
                    }
                } catch {
                    completion(.failure(error))
                    return
                }
            })
        }
    }
}
