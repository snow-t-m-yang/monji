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

    func signIn() {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }

        Task {
            do {
                let returnedUserData = try await AuthManager.shared.createUser(
                    email: email, password: password)
                print("Created user: \(returnedUserData.uid)")
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

struct SignInEmailView: View {
    @State private var viewModal = SignInWithEmailViewModel()

    var body: some View {
        VStack {
            TextField("Email...", text: $viewModal.email)
                .padding()
                .background(.secondary.opacity(0.3))
                .cornerRadius(30)

            SecureField("Password", text: $viewModal.password)
                .padding()
                .background(.secondary.opacity(0.3))
                .cornerRadius(30)

            Button {
                viewModal.signIn()
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
        SignInEmailView()
    }
}
