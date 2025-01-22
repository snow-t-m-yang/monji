//
//  AuthView.swift
//  monji
//
//  Created by snow on 2025/1/20.
//

import FirebaseAuth
import SwiftUI

struct AuthView: View {
    var body: some View {
        VStack {
            NavigationLink {
                SignInEmailView()
            } label: {
                Text("Sign In With Email")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(.black.opacity(0.9))
                    .cornerRadius(30)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Sign In")
    }
}

#Preview {
    NavigationStack {
        AuthView()
    }
}
