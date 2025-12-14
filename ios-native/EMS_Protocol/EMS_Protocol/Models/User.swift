//
//  User.swift
//  EMS Protocol
//
//  Created by Claude Code
//

import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    var username: String
    var email: String
    var role: UserRole
    var certificationLevel: CertificationLevel
    var state: String // Two-letter state code
    var agency: String
    var preferredWeightUnit: WeightUnit
    var createdAt: Date
    var lastLogin: Date?

    init(
        id: UUID = UUID(),
        username: String,
        email: String,
        role: UserRole,
        certificationLevel: CertificationLevel,
        state: String,
        agency: String,
        preferredWeightUnit: WeightUnit = .kg,
        createdAt: Date = Date(),
        lastLogin: Date? = nil
    ) {
        self.id = id
        self.username = username
        self.email = email
        self.role = role
        self.certificationLevel = certificationLevel
        self.state = state
        self.agency = agency
        self.preferredWeightUnit = preferredWeightUnit
        self.createdAt = createdAt
        self.lastLogin = lastLogin
    }
}

enum UserRole: String, Codable {
    case editor = "Editor"
    case regularUser = "Regular User"

    var canEdit: Bool {
        self == .editor
    }
}

enum WeightUnit: String, Codable, CaseIterable {
    case kg = "kg"
    case lbs = "lbs"

    func convert(_ weight: Double, to targetUnit: WeightUnit) -> Double {
        if self == targetUnit {
            return weight
        }

        switch (self, targetUnit) {
        case (.kg, .lbs):
            return weight * 2.20462
        case (.lbs, .kg):
            return weight / 2.20462
        default:
            return weight
        }
    }
}
