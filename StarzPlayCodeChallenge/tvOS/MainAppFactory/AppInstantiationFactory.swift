//
//  AppInstantiationFactory.swift
//  StarzPlayCodeChallengeTV
//
//  Created by Qazi Mudassar on 04/09/2024.
//

import Foundation

struct AppInstantiationFactory {
     func startApp() -> HomeView {
          homeView()
     }
     
     func homeView() -> HomeView {
          HomeView(
               viewModel: HomeViewModel(
                    mediaEndpointConfig: MediaEndPointManger.createEndpoints()
               )
          )
     }
}
