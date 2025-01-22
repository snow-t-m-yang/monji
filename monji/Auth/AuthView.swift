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
            Spacer()
            NavigationLink {
                SignInEmailView()
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
    }
}

#Preview {
    NavigationStack {
        AuthView()
    }
}
