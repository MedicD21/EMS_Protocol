//
//  SettingsView.swift
//  EMS Protocol
//
//  Created by Claude Code
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @EnvironmentObject var protocolStore: ProtocolStore
    @EnvironmentObject var dosingCalculator: DosingCalculator
    @State private var showingLogoutAlert = false

    var body: some View {
        NavigationView {
            Form {
                // User Profile Section
                Section(header: Text("Profile")) {
                    if let user = authManager.currentUser {
                        HStack {
                            Text("Username")
                            Spacer()
                            Text(user.username)
                                .foregroundColor(.secondary)
                        }

                        HStack {
                            Text("Email")
                            Spacer()
                            Text(user.email)
                                .foregroundColor(.secondary)
                        }

                        HStack {
                            Text("Role")
                            Spacer()
                            HStack {
                                Text(user.role.rawValue)
                                    .foregroundColor(user.role == .editor ? .blue : .secondary)
                                if user.role == .editor {
                                    Image(systemName: "pencil.circle.fill")
                                        .foregroundColor(.blue)
                                }
                            }
                        }

                        HStack {
                            Text("Certification")
                            Spacer()
                            Text(user.certificationLevel.displayName)
                                .foregroundColor(user.certificationLevel.color)
                        }

                        HStack {
                            Text("State")
                            Spacer()
                            Text(user.state)
                                .foregroundColor(.secondary)
                        }

                        HStack {
                            Text("Agency")
                            Spacer()
                            Text(user.agency)
                                .foregroundColor(.secondary)
                        }
                    }
                }

                // Preferences Section
                Section(header: Text("Preferences")) {
                    Picker("Default Weight Unit", selection: $dosingCalculator.weightUnit) {
                        Text("Kilograms (kg)").tag(WeightUnit.kg)
                        Text("Pounds (lbs)").tag(WeightUnit.lbs)
                    }

                    if let user = authManager.currentUser {
                        Picker("State Protocols", selection: $protocolStore.selectedState) {
                            Text("National").tag("National")
                            Text(user.state).tag(user.state)
                        }
                    }
                }

                // Editor Tools (only for editors)
                if authManager.currentUser?.role.canEdit == true {
                    Section(header: Text("Editor Tools")) {
                        NavigationLink(destination: DocumentScannerView()) {
                            HStack {
                                Image(systemName: "doc.text.viewfinder")
                                    .foregroundColor(.blue)
                                Text("Scan Protocol Document")
                            }
                        }

                        NavigationLink(destination: Text("Import Protocols")) {
                            HStack {
                                Image(systemName: "square.and.arrow.down")
                                    .foregroundColor(.blue)
                                Text("Import Protocols")
                            }
                        }

                        NavigationLink(destination: Text("Export Protocols")) {
                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                    .foregroundColor(.blue)
                                Text("Export Protocols")
                            }
                        }
                    }
                }

                // About Section
                Section(header: Text("About")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }

                    HStack {
                        Text("Guidelines")
                        Spacer()
                        Text("National Model EMS Clinical Guidelines")
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.trailing)
                    }

                    NavigationLink(destination: Text("Help & Support")) {
                        Text("Help & Support")
                    }

                    NavigationLink(destination: Text("Privacy Policy")) {
                        Text("Privacy Policy")
                    }

                    NavigationLink(destination: Text("Terms of Service")) {
                        Text("Terms of Service")
                    }
                }

                // Logout Section
                Section {
                    Button(action: { showingLogoutAlert = true }) {
                        HStack {
                            Spacer()
                            Text("Logout")
                                .foregroundColor(.red)
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .alert(isPresented: $showingLogoutAlert) {
                Alert(
                    title: Text("Logout"),
                    message: Text("Are you sure you want to logout?"),
                    primaryButton: .destructive(Text("Logout")) {
                        authManager.logout()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
}

struct DocumentScannerView: View {
    @State private var showingImagePicker = false
    @State private var showingCamera = false
    @State private var processingDocument = false

    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "doc.text.viewfinder")
                .font(.system(size: 100))
                .foregroundColor(.blue)

            Text("AI Document Scanner")
                .font(.title)
                .fontWeight(.bold)

            Text("Scan EMS protocol documents and automatically convert them to interactive flowcharts")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            VStack(spacing: 16) {
                Button(action: { showingCamera = true }) {
                    HStack {
                        Image(systemName: "camera.fill")
                        Text("Take Photo")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                }

                Button(action: { showingImagePicker = true }) {
                    HStack {
                        Image(systemName: "photo.fill")
                        Text("Choose from Library")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                }
            }
            .padding(.horizontal, 40)

            if processingDocument {
                VStack(spacing: 12) {
                    ProgressView()
                    Text("Processing document with AI...")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            VStack(spacing: 8) {
                Text("Powered by Advanced AI")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("Supports PDFs, Images, and Scanned Documents")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .padding(.bottom, 20)
        }
        .navigationTitle("Document Scanner")
        .navigationBarTitleDisplayMode(.inline)
    }
}
