//
//  EMS_ProtocolApp.swift
//  EMS Protocol
//
//  Created by Claude Code
//  Copyright © 2024. All rights reserved.
//

import SwiftUI

@main
struct EMS_ProtocolApp: App {
    @StateObject private var authManager = AuthenticationManager()
    @StateObject private var protocolStore = ProtocolStore()
    @StateObject private var dosingCalculator = DosingCalculator()

    var body: some Scene {
        WindowGroup {
            if authManager.isAuthenticated {
                MainTabView()
                    .environmentObject(authManager)
                    .environmentObject(protocolStore)
                    .environmentObject(dosingCalculator)
            } else {
                LoginView()
                    .environmentObject(authManager)
            }
        }
    }
}
