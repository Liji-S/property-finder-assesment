//
//  Date+Relative.swift
//  Tahudu
//

import Foundation

extension Date {
    var relativeDescription: String {
        RelativeDateTimeFormatter.propertyFinder.localizedString(for: self, relativeTo: Date())
    }
}
