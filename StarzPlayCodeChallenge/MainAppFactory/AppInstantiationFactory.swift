//
//  AppInstantiationFactory.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 13/07/2023.
//

import Foundation
import SwiftUI

 struct AppInstantiationFactory {
     
     func startApp() -> HomeView {
        homeView()
    }
    
     func homeView() -> HomeView {
          HomeView(
               viewModel: HomeViewModel(mediaEndpointConfig: MediaEndPointManger.createEndpoints())
          )
     }
    
    func detailView(for mediaId: Int, and contentType: ContentType) -> AnyView {
        if contentType == .person {
          return AnyView (personDetailView(for: mediaId))
        }
        return AnyView(mediaDetailView(for: mediaId, contentType: contentType))
    }
    
    private func mediaDetailView(for mediaId: Int, contentType: ContentType) -> DetailView {
       let vm = makeDetailVM(for: mediaId, and: contentType)
       return DetailView(
           viewModel: vm,
           dynamicContentView: {
               self.makeDetailSubView(for: mediaId, contentType: contentType, viewModel: vm)
           },
           url: videoUrl()
       )
   }
    
    func personDetailView(for mediaId: Int) -> PersonDetailView {
        let vm = PersonDetailVM(detailService: PersonDetailServiceAdapter(), id: mediaId)
        return PersonDetailView(viewModel: vm)
    }
    
    private func makeDetailVM(for mediaId: Int, and contentType: ContentType) -> DetailVM {
         DetailVM(detailService: contentType.adpter, id: mediaId)
    }
    
    private func makeDetailSubView(for mediaId: Int,contentType: ContentType, viewModel: DetailVM) -> AnyView? {
        contentType == .movie ? recommendationView(viewModel) : seasonView(viewModel, mediaId)
    }
    
      private func recommendationView(_ viewModel: DetailVM) -> AnyView? {
           guard let movieDetail = viewModel.detail as? MovieDetail else { return nil }
           guard let recommendations = movieDetail.getRecommendations()?.results ,
                 !recommendations.isEmpty else { return nil }
           return AnyView(PosterRowView(layout: Layout( sectionTitle: "Recommendations", titles: recommendations)))
      }
    
      private func seasonView(_ viewModel: DetailVM, _ mediaId: Int) -> AnyView? {
           guard let tvDetail = viewModel.detail as? TvDetail else { return nil }
           guard let seasons = tvDetail.getSeasons(),
                 !seasons.isEmpty else { return nil }
           let seasonVM =  SeasonGridVM(seaasonService: EpisodeServiceAdpter(),seasons: seasons)
           return AnyView(SeasonGridView(viewModel: seasonVM, mediaId: mediaId))
      }
    
    private func videoUrl() -> URL {
        URL(string: AppUrl.VURL)!
    }
}
