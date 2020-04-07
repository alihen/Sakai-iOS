//
//  CalendarService.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2020/04/07.
//

import Foundation

public class CalendarService {

    public func getSiteCalendar(siteId: String, completion: @escaping NetworkServiceResponse<SakaiCalendarCollection>) {
        SakaiAPIClient.shared.session.prepAuthedRoute { (sessionResult) in
            if let authError = sessionResult.error {
                completion(.failure(authError))
                return
            }

            sakaiProvider.request(.calendarSite(siteId)) { result in
                completion(ResponseHelper.handle(SakaiCalendarCollection.self, result: result))
            }
        }
    }

    public func getSiteCalendarEvent(siteId: String, eventId: String, completion: @escaping NetworkServiceResponse<SakaiCalendarItem>) {
        SakaiAPIClient.shared.session.prepAuthedRoute { (sessionResult) in
            if let authError = sessionResult.error {
                completion(.failure(authError))
                return
            }

            sakaiProvider.request(.calendarEvent(siteId, eventId)) { result in
                completion(ResponseHelper.handle(SakaiCalendarItem.self, result: result))
            }
        }
    }

    public func getUserCalendar(completion: @escaping NetworkServiceResponse<SakaiCalendarCollection>) {
        SakaiAPIClient.shared.session.prepAuthedRoute { (sessionResult) in
            if let authError = sessionResult.error {
                completion(.failure(authError))
                return
            }

            sakaiProvider.request(.calendarMy) { result in
                completion(ResponseHelper.handle(SakaiCalendarCollection.self, result: result))
            }
        }
    }
}
