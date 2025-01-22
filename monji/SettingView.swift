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
    func signOut() throws {
        try AuthManager.shared.signOut()
    }
}

struct SettingView: View {
    @State private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool

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
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingView(showSignInView: .constant(true))
    }
}
