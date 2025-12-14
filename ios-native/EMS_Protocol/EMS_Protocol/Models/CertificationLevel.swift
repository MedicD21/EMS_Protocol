//
//  CertificationLevel.swift
//  EMS Protocol
//
//  Created by Claude Code
//

import SwiftUI

enum CertificationLevel: String, Codable, CaseIterable, Identifiable {
    case emr = "EMR"
    case emt = "EMT"
    case aemt = "AEMT"
    case paramedic = "Paramedic"

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .emr:
            return "Emergency Medical Responder"
        case .emt:
            return "Emergency Medical Technician"
        case .aemt:
            return "Advanced EMT"
        case .paramedic:
            return "Paramedic"
        }
    }

    var color: Color {
        switch self {
        case .emr:
            return .green
        case .emt:
            return .blue
        case .aemt:
            return .yellow
        case .paramedic:
            return .red
        }
    }

    var hexColor: String {
        switch self {
        case .emr:
            return "#34C759"
        case .emt:
            return "#007AFF"
        case .aemt:
            return "#FFD60A"
        case .paramedic:
            return "#FF3B30"
        }
    }

    var skillLevel: Int {
        switch self {
        case .emr:
            return 1
        case .emt:
            return 2
        case .aemt:
            return 3
        case .paramedic:
            return 4
        }
    }
}
