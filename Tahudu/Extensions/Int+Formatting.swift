//
//  Int+Formatting.swift
//  Tahudu
//

import Foundation

extension Int {
    var formattedGrouped: String {
        NumberFormatter.propertyFinderDecimal.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
