//
//  MainTabView.swift
//  EMS Protocol
//
//  Created by Claude Code
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @EnvironmentObject var protocolStore: ProtocolStore
    @EnvironmentObject var dosingCalculator: DosingCalculator

    var body: some View {
        TabView {
            ProtocolsListView()
                .tabItem {
                    Label("Protocols", systemImage: "doc.text.fill")
                }

            ProceduresListView()
                .tabItem {
                    Label("Procedures", systemImage: "list.clipboard.fill")
                }

            PharmacologyListView()
                .tabItem {
                    Label("Medications", systemImage: "pills.fill")
                }

            DosingCalculatorView()
                .tabItem {
                    Label("Dosing", systemImage: "scalemass.fill")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
        .environmentObject(authManager)
        .environmentObject(protocolStore)
        .environmentObject(dosingCalculator)
    }
}
