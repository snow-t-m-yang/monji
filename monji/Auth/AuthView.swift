//
//  AuthView.swift
//  monji
//
//  Created by snow on 2025/1/20.
//

import GoogleSignIn
import GoogleSignInSwift
import SwiftUI

@MainActor
@Observable
final class AuthViewModel {

    func singInWithGoogle() async throws {
        guard let topVC = Ultils.shared.getTopViewController() else {
            print("No topVC found")
            return
        }

        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(
            withPresenting: topVC)

        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            print("Can't get idToken")
            return
        }
        let accessToken = gidSignInResult.user.accessToken.tokenString

        let tokens = GoogleSignInResultModel(
            idToken: idToken, accessToken: accessToken)

        try await AuthManager.shared.signInWithGoogle(with: tokens)
    }

}

struct AuthView: View {
    @State private var viewModel = AuthViewModel()
    @Binding var showSignInView: Bool

    var body: some View {
        VStack {
            Spacer()
            // TODO: Create sign up flow
            NavigationLink {
                SignInEmailView(showSignInView: $showSignInView)
            } label: {
                Text("Sign In With Email")
                    .font(.headline)
                    .foregroundStyle(Color("primary-background"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color("primary-foreground"))
                    .cornerRadius(30)
            }
        }
        .padding()
        .navigationTitle("Sign In")

        GoogleSignInButton(
            viewModel: GoogleSignInButtonViewModel(
                scheme: .dark, style: .icon, state: .normal)
        ) {
            Task {
                do {
                    try await viewModel.singInWithGoogle()
                    showSignInView = false
                } catch {
                    print("Sign in with Google Error: \(error)")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AuthView(showSignInView: .constant(false))
    }
}
