//
//  ContentView.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar Tanveer on 08/09/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        NavigationView {
            let adpter = SeasonServiceAdpter()
            let viewModel = TVDetailVM(seaasonService: adpter)
            HideNavbarOf(view: TVDetailView(viewModel: viewModel))
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
