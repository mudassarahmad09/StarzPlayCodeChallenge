//
//  HomeViewModel.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 11/07/2023.
//

import SwiftUI
import MyApiLibrary

final class HomeViewModel: ObservableObject {
    
    private let mediaEndpointConfig : [MediaEndpointConfig]
    
    @Published private(set) var layouts: [Layout]?
    @Published private(set) var loading = false
    @Published var showError = false
    
    var errorMessage = ""
    
    init( mediaEndpointConfig: [MediaEndpointConfig]) {
        self.mediaEndpointConfig = mediaEndpointConfig
    }
}
// MARK: - fetch List of array
extension HomeViewModel {
    @MainActor
    func fetchTvShowsList() async {
        loading = true
        await withTaskGroup(of: (String, Result<[MediaAttributes], RequestError>).self) { group in
            for endpoint in mediaEndpointConfig {
                group.addTask {
                    let result = await endpoint.adpter.fetchList(endPoint: endpoint.endPoint)
                    return (endpoint.title, result)
                }
            }
            
            for await (title, result) in group {
                await handleTvshowsResult(title: title, result: result)
            }
        }
        
        loading = false
    }
    
    @MainActor
    private func handleTvshowsResult(title: String , result: Result<[any MediaAttributes], RequestError>) async {
        switch result {
        case let .success(titles):
            if layouts == nil {
                layouts = []
            }
            layouts?.append(Layout(sectionTitle: title, titles: titles))
        case let .failure(error):
            self.errorMessage = error.customMessage
            self.showError = true
        }
    }
}

struct Layout: Identifiable {
    let id = UUID()
    let sectionTitle: String
    let titles: [any MediaAttributes]
}
