//
//  SigninEmailView.swift
//  monji
//
//  Created by snow on 2025/1/20.
//

import SwiftUI

@Observable
@MainActor
final class SignInWithEmailViewModel {
    var email: String = ""
    var password: String = ""

    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }

        let returnedUserData = try await AuthManager.shared.createUser(
            email: email, password: password)
        print("Created user: \(returnedUserData.uid)")
    }

    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("Sign In Error: No email or password found.")
            return
        }

        let returnedUserData = try await AuthManager.shared.signIn(
            email: email, password: password)
        print("Sign In Success: \(returnedUserData)")
    }
}

struct SignInEmailView: View {
    @State private var viewModel = SignInWithEmailViewModel()
    @Binding var showSignInView: Bool

    var body: some View {
        VStack {
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(.secondary.opacity(0.3))
                .cornerRadius(30)

            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(.secondary.opacity(0.3))
                .cornerRadius(30)

            Button {
                Task {
                    do {
                        try await viewModel.signUp()
                        showSignInView = false
                        return
                    } catch {
                        print("Error \(error)")
                    }
                    
                    do {
                        try await viewModel.signIn()
                        showSignInView = false
                        return
                    } catch {
                        print("Error \(error)")
                    }
                }
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(.black.opacity(0.9))
                    .cornerRadius(30)
            }
            .padding(.top)

        }
        .padding()
        .navigationTitle("Sign In With Email")
    }
}

#Preview {
    NavigationStack {
        SignInEmailView(showSignInView: .constant(false))
    }
}
