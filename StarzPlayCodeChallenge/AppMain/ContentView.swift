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
            let app = AppInstantiationFactory()
            
            HideNavbarOf(
                view: TVDetailView(
                    viewModel: app.makeSeasonDetailVM(),
                    viewModelForSeason: { seasons in
                        app.makeSeasonVm(for: seasons)
                    },
                    url: app.videoUrl()
                )
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
