//
//  SettingView.swift
//  monji
//
//  Created by snow on 2025/1/21.
//

import SwiftUI

@MainActor
@Observable
final class SettingsViewModel {
    func getCurrentUser() throws -> AuthDataResultModel? {
        try AuthManager.shared.getUser()
    }

    func signOut() throws {
        try AuthManager.shared.signOut()
    }

    func resetPassword(user: AuthDataResultModel?) async throws {
        guard let user = user else {
            print("No User")
            return
        }

        try await AuthManager.shared.resetPassword(email: user.email)
    }
    
    func updateEmail(email: String) async throws {
        try await AuthManager.shared.updateEmail(email: email)
    }
    
    func updatePassword(password: String) async throws {
        try await AuthManager.shared.updatePassword(password: password)
    }
}

struct SettingView: View {
    @State private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    @State var user: AuthDataResultModel?

    var body: some View {
        List {
            Button("Sign Out") {
                Task {
                    do {
                        try viewModel.signOut()
                        showSignInView = true
                    } catch {
                        print("Error signing out: \(error)")
                    }
                }
            }

            // TODO: Add Remote config to turn it off
            Button("Reset Password") {
                Task {
                    do {
                        try await viewModel.resetPassword(user: user)
                    } catch {
                        print("Reset Password Error: \(error)")
                    }
                }
            }
        }
        .navigationTitle("Settings")
        .onAppear {
            let maybeUser = try? viewModel.getCurrentUser()
            user = maybeUser
            print(user ?? "No User")
        }
    }
}

#Preview {
    NavigationStack {
        SettingView(showSignInView: .constant(true))
    }
}
