//
//  ContentView.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar Tanveer on 08/09/2022.
//

import SwiftUI
import AVKit

struct ContentView: View {
    var body: some View {

        NavigationView {
            let adpter = SeasonServiceAdpter()
            let viewModel = TVDetailVM(seaasonService: adpter)
            let avPlayer = AVPlayer(url: URL(string: AppUrl.VURL)!)

            HideNavbarOf(view:
                            TVDetailView(
                                viewModel: viewModel,
                                viewModelForSeason: { seasons in
                                                        SeasonGridVM(seasons: seasons)
                                                    },
                                player: avPlayer))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
