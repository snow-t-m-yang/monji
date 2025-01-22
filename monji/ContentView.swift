//
//  ContentView.swift
//  monji
//
//  Created by snow on 2025/1/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {

            VStack {

                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("are we cool?")
            }
        }
        .ignoresSafeArea(.all)
        .padding()
    }
}

#Preview {
    ContentView()
}
