//
//  HomeViewModel.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 11/07/2023.
//

import SwiftUI
import MyApiLibrary

@Observable
final class HomeViewModel {
    
    private let mediaEndpointConfig : [MediaEndpointConfig]
    
    private(set) var layouts: [Layout] = []
    private(set) var loading = false
    var showError = false
    
    @ObservationIgnored var errorMessage = ""
    
    init( mediaEndpointConfig: [MediaEndpointConfig]) {
        self.mediaEndpointConfig = mediaEndpointConfig
    }
}
// MARK: - fetch List of array
@MainActor
extension HomeViewModel {
     
     func fetchTvShowsList() async {
          guard !loading else { return }
          defer { loading = false }
          loading = true
          
          for endpoint in mediaEndpointConfig {
               if layouts.contains(where: { $0.sectionTitle == endpoint.title }) {
                    continue
               }
               
               let result = await endpoint.adpter.fetchList(endPoint: endpoint.endPoint)
               await handleTvshowsResult(title: endpoint.title, result: result)
          } 
     }
    
    private func handleTvshowsResult(title: String , result: Result<[MediaAttributes], RequestError>) async {
        switch result {
        case let .success(titles):
            layouts.append(Layout(sectionTitle: title, titles: titles))
        case let .failure(error):
            self.errorMessage = error.customMessage
            self.showError = true
        }
    }
}

struct Layout: Identifiable {
    let id = UUID()
    let sectionTitle: String
    let titles: [MediaAttributes]
}
