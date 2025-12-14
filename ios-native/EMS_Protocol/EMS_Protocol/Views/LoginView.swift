//
//  LoginView.swift
//  EMS Protocol
//
//  Created by Claude Code
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @State private var username = ""
    @State private var password = ""
    @State private var showingRegistration = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Logo/Header
                VStack(spacing: 10) {
                    Image(systemName: "cross.case.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.red)

                    Text("EMS Protocol")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Clinical Guidelines & Reference")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 60)
                .padding(.bottom, 40)

                // Login Form
                VStack(spacing: 15) {
                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .disableAutocorrection(true)

                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    if let errorMessage = authManager.errorMessage {
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundColor(.red)
                    }

                    Button(action: {
                        authManager.login(username: username, password: password)
                    }) {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .disabled(username.isEmpty || password.isEmpty)

                    Button(action: {
                        showingRegistration = true
                    }) {
                        Text("Create Account")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal, 40)

                Spacer()

                // Quick Access Info
                VStack(spacing: 5) {
                    Text("Demo Credentials:")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("Editor: 'editor' / Regular User: 'user'")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text("Password: any")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 20)
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showingRegistration) {
                RegistrationView()
                    .environmentObject(authManager)
            }
        }
    }
}

struct RegistrationView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @Environment(\.presentationMode) var presentationMode

    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var certificationLevel: CertificationLevel = .emt
    @State private var state = "CA"
    @State private var agency = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Account Information")) {
                    TextField("Username", text: $username)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)

                    TextField("Email", text: $email)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .disableAutocorrection(true)

                    SecureField("Password", text: $password)
                    SecureField("Confirm Password", text: $confirmPassword)
                }

                Section(header: Text("Professional Information")) {
                    Picker("Certification Level", selection: $certificationLevel) {
                        ForEach(CertificationLevel.allCases) { level in
                            Text(level.displayName).tag(level)
                        }
                    }

                    TextField("State (2-letter code)", text: $state)
                        .autocapitalization(.allCharacters)
                        .disableAutocorrection(true)

                    TextField("Agency", text: $agency)
                }

                Section {
                    Button(action: register) {
                        Text("Register")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.blue)
                    }
                    .disabled(!isValid)
                }
            }
            .navigationTitle("Create Account")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }

    private var isValid: Bool {
        !username.isEmpty &&
        !email.isEmpty &&
        !password.isEmpty &&
        password == confirmPassword &&
        !state.isEmpty &&
        !agency.isEmpty
    }

    private func register() {
        authManager.register(
            username: username,
            email: email,
            password: password,
            certificationLevel: certificationLevel,
            state: state,
            agency: agency
        )
        presentationMode.wrappedValue.dismiss()
    }
}
