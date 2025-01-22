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
    let email: String?
    let photoUrl: String?

    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        // Use a string for Firebase type compatibility
        self.photoUrl = user.photoURL?.absoluteString
    }
}

final class AuthManager {
    static let shared = AuthManager()

    private init() {}

    func createUser(email: String, password: String) async throws
        -> AuthDataResultModel
    {
        let authDataResult = try await Auth.auth().createUser(
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
}
