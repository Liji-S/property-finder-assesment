//
//  ContactType.swift
//  Tahudu
//

import SwiftUI

/// Represents the various contact types
enum ContactType: String, CaseIterable, Codable {
    case phone
    case email
    case whatsApp = "whatsapp"
    case sms

    var imageName: String? {
        switch self {
        case .whatsApp:
            return "whatsapp"
        default:
            return nil
        }
    }

    var imageNameFilled: String? {
        imageName?.filled
    }

    var imageSystemName: String? {
        switch self {
        case .phone:
            return "phone"
        case .email:
            return "envelope"
        case .sms:
            return "message"
        default:
            return nil
        }
    }

    var imageSystemNameFilled: String? {
        imageSystemName?.filled
    }

    var backgroundColor: Color {
        switch self {
        case .phone, .email, .sms:
            return .brand
        case .whatsApp:
            return .whatsApp
        }
    }

    var analyticsName: String {
        switch self {
        case .phone:
            return "phone"
        case .email:
            return "email"
        case .whatsApp:
            return "whatsapp"
        case .sms:
            return "sms"
        }
    }
}

private extension String {
    var filled: String {
        self + ".fill"
    }
}
