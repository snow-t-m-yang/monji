//
//  AuthManager.swift
//  monji
//
//  Created by snow on 2025/1/20.
//

import FirebaseAuth
import Foundation

struct AuthDataResultModel {
    let uid: String
    let email: String
    let photoUrl: String?

    init(user: User) {
        self.uid = user.uid
        self.email = user.email!
        // Use a string for Firebase type compatibility
        self.photoUrl = user.photoURL?.absoluteString
    }
}

final class AuthManager {
    static let shared = AuthManager()

    private init() {}

    @discardableResult
    func createUser(email: String, password: String) async throws
        -> AuthDataResultModel
    {
        let authDataResult = try await Auth.auth().createUser(
            withEmail: email, password: password)

        return AuthDataResultModel(user: authDataResult.user)
    }

    @discardableResult
    func signIn(email: String, password: String) async throws
        -> AuthDataResultModel
    {
        let authDataResult = try await Auth.auth().signIn(
            withEmail: email, password: password)

        return AuthDataResultModel(user: authDataResult.user)
    }

    func getUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }

        return AuthDataResultModel(user: user)
    }

    func signOut() throws {
        try Auth.auth().signOut()
    }

    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }

    func updateEmail(email: String) async throws {
        guard let user = Auth.auth().currentUser else {
            print("Update Email error: No current user")
            return
        }

        try await user.sendEmailVerification(beforeUpdatingEmail: email)
    }

    func updatePassword(password: String) async throws {
        guard let user = Auth.auth().currentUser else {
            print("Update password error: No current user")
            return
        }

        try await user.updatePassword(to: password)
    }
}
