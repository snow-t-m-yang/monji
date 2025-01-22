//
//  monjiApp.swift
//  monji
//
//  Created by snow on 2025/1/20.
//

import FirebaseCore
import SwiftUI

@main
struct monjiApp: App {
    init() {
        FirebaseApp.configure()
        print("configured firebase")
    }

    var body: some Scene {
        WindowGroup {
            //            ContentView()
           RootView()
        }
    }
}
