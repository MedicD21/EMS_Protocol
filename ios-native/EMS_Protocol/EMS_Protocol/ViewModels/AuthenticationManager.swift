//
//  AuthenticationManager.swift
//  EMS Protocol
//
//  Created by Claude Code
//

import Foundation
import Combine

class AuthenticationManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    @Published var errorMessage: String?

    private let userDefaultsKey = "currentUser"

    init() {
        loadUser()
    }

    func login(username: String, password: String) {
        // TODO: Implement actual authentication with backend
        // For now, this is a mock implementation

        // Mock validation
        if username.isEmpty || password.isEmpty {
            errorMessage = "Username and password are required"
            return
        }

        // Mock user creation based on username pattern
        let role: UserRole = username.lowercased().contains("editor") ? .editor : .regularUser

        // Create mock user
        let user = User(
            username: username,
            email: "\(username)@example.com",
            role: role,
            certificationLevel: .paramedic,
            state: "CA",
            agency: "Sample EMS Agency",
            lastLogin: Date()
        )

        currentUser = user
        isAuthenticated = true
        errorMessage = nil
        saveUser()
    }

    func logout() {
        currentUser = nil
        isAuthenticated = false
        clearUser()
    }

    func register(username: String, email: String, password: String, certificationLevel: CertificationLevel, state: String, agency: String) {
        // TODO: Implement actual registration with backend

        let user = User(
            username: username,
            email: email,
            role: .regularUser,
            certificationLevel: certificationLevel,
            state: state,
            agency: agency
        )

        currentUser = user
        isAuthenticated = true
        errorMessage = nil
        saveUser()
    }

    private func saveUser() {
        if let user = currentUser,
           let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }

    private func loadUser() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let user = try? JSONDecoder().decode(User.self, from: data) {
            currentUser = user
            isAuthenticated = true
        }
    }

    private func clearUser() {
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
    }
}
