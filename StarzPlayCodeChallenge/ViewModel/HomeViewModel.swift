//
//  HomeViewModel.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 11/07/2023.
//

import SwiftUI
import MyApiLibrary

final class HomeViewModel: ObservableObject {
    
    private let mediaListEndPoints : [MediaListEndPoints]
    
    @Published private(set) var layouts: [Layout]?
    @Published var showError = false
    @Published var loading = false
    var errorMessage = ""
    
    init( endPosints: [MediaListEndPoints]) {
        self.mediaListEndPoints = endPosints
    }
}
// MARK: - fetch List of array
extension HomeViewModel {
    @MainActor
    func fetchTvShowsList() async {
        for endpoint in mediaListEndPoints {
            loading = true
            await handleTvshowsResult(title: endpoint.title,
                                      result: endpoint.adpter.fetchList(endPoint:
                                                                        endpoint.endPoint))
            loading = false
        }
    }
    
    @MainActor
    private func handleTvshowsResult(title: String , result: Result<[Title], RequestError>) async {
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
    let titles: [Title]
}
