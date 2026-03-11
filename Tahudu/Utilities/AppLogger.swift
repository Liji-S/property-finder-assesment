//
//  AppLogger.swift
//  Tahudu
//

import Foundation

// Here I have used a basic Logging feature which can be used anywhere in the app.
enum AppLogger {
    static func log(_ message: String) {
        print("[Tahudu] \(message)")
    }
}
