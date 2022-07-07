//
//  Formatter.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 05/07/22.
//

import Foundation

extension Formatter {
    static let iso8601: DateFormatter = {
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSX"
            return formatter
   }()
}
