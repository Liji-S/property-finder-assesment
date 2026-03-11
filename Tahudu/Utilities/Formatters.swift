//
//  Formatters.swift
//  Tahudu
//

import Foundation

extension NumberFormatter {
    static let propertyFinderDecimal: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.maximumFractionDigits = 0
        return formatter
    }()
}

extension RelativeDateTimeFormatter {
    static let propertyFinder: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter
    }()
}
