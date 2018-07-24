//
//  String.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2018/05/20.
//

import Foundation

extension String {

	internal func stripHTML() -> String? {
		let htmlString = self
		guard let htmlStringData = htmlString.data(using: .utf8) else {
			return nil
		}

		let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
			NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
			NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue
		]
		let attributedHTMLString = try? NSAttributedString(data: htmlStringData, options: options, documentAttributes: nil)
		var result = attributedHTMLString?.string.replacingOccurrences(of: "\n", with: " ")
		result = result?.trimmingCharacters(in: .whitespaces)
		return result
	}
}
