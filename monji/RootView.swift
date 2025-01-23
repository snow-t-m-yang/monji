//
//  RootView.swift
//  monji
//
//  Created by snow on 2025/1/21.
//

import SwiftUI

struct RootView: View {

    @State private var showSignInView: Bool = false

    var body: some View {
        ZStack {
            NavigationStack {
                SettingView(showSignInView: $showSignInView)
            }
        }
        .onAppear {
            let user = try? AuthManager.shared.getUser()
            showSignInView = user == nil
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                AuthView(showSignInView: $showSignInView)
            }
        }
    }
}

#Preview {
    RootView()
}
