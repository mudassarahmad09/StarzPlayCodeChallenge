//
//  ContentView.swift
//  StarzPlayCodeChallengeTV
//
//  Created by Qazi Mudassar on 28/08/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
         NavigationStack {
              HomeView(belowFold: true)
         }
    }
}

#Preview {
    ContentView()
}
