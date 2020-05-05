//
//  PortalHTMLParser.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2020/05/04.
//

import Foundation
import SwiftSoup

class PortalHTMLParser {
    class func parsePortalHTML(html: String,
                               sectionSelector: String,
                               termSelector: String,
                               siteSelector: String,
                               dataSelector: String) -> [SakaiPortalSiteSection] {
        var sakaiPortalSections: [SakaiPortalSiteSection] = []
        do {
            let doc: Document = try SwiftSoup.parse(html)
            let userCourseSections: Elements = try doc.select(sectionSelector)
            for courseSection in userCourseSections.array() {
                let termString = try courseSection.select(termSelector).text()
                let courseData: Elements = try courseSection.select(siteSelector)
                var sakaiPortalCourses: [SakaiPortalSite] = []
                for course in courseData.array() {
                    let courseTitle = try course.text()
                    let courseId = try course.select("a[\(dataSelector)]").attr(dataSelector)
                    let site = SakaiPortalSite(id: courseId, title: courseTitle)
                    if !courseId.isEmpty {
                        sakaiPortalCourses.append(site)
                    }
                }
                let section = SakaiPortalSiteSection(term: termString, sites: sakaiPortalCourses)
                sakaiPortalSections.append(section)
            }

            return sakaiPortalSections
        } catch {
            return sakaiPortalSections
        }
    }
}
