//
//  AppInstantiationFactory.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 13/07/2023.
//

import Foundation
import SwiftUI

final class AppInstantiationFactory {
    
    @MainActor func startApp() -> HomeView {
        homeView()
    }
    
    func homeView() -> HomeView {
        HomeView(viewModel:
                    HomeViewModel(mediaEndpointConfig: MediaEndPointManger.createEndpoints()))
    }
    
    func detailView(for mediaId: Int, and contentType: ContentType) -> DetailView {
        let vm = makeDetailVM(for: mediaId, and: contentType)
        return DetailView(
            viewModel: vm,
            dynamicContentView: {
                self.makeDetailSubView(for: mediaId, contentType: contentType, viewModel: vm)
            },
            url: videoUrl()
        )
    }
    
    private func makeDetailVM(for mediaId: Int, and contentType: ContentType) -> DetailVM {
        let adpter: MediaDetailService = contentType == .movie ?
        MovieDetailServiceAdapter() :
        TVDetailServiceAdapter()
        return DetailVM(detailService: adpter, id: mediaId)
    }
    
    private func makeDetailSubView(for mediaId: Int,contentType: ContentType, viewModel: DetailVM) -> AnyView? {
        contentType == .movie ? recommendationView(viewModel) : seasonView(viewModel, mediaId)
    }
    
    private func recommendationView(_ viewModel: DetailVM) -> AnyView? {
        guard let recommendations = viewModel.detail?.getRecommendations()?.results , !recommendations.isEmpty else {return nil}
        return AnyView(PosterRowView(layout: Layout( sectionTitle: "Recommendations", titles: recommendations)))
    }
    
    private func seasonView(_ viewModel: DetailVM, _ mediaId: Int) -> AnyView? {
        guard let seasons = viewModel.detail?.getSeasons() , !seasons.isEmpty else {return nil}
        let seasonVM =  SeasonGridVM(seaasonService: EpisodeServiceAdpter(),seasons: seasons)
        return AnyView(SeasonGridView(viewModel: seasonVM, mediaId: mediaId))
    }
    
    private func videoUrl() -> URL {
        URL(string: AppUrl.VURL)!
    }
}
