//
//  AppInstantiationFactory.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 13/07/2023.
//

import Foundation
import SwiftUI

@MainActor
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
     
     func detailView(for mediaId: Int, and contentType: ContentType) -> DetailView {
          mediaDetailView(for: mediaId, contentType: contentType)
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
     
     private func makeDetailVM(for mediaId: Int, and contentType: ContentType) -> DetailVM {
          DetailVM(detailService: contentType.adpter, id: mediaId)
     }
     
     private func makeDetailSubView(for mediaId: Int,contentType: ContentType, viewModel: DetailVM) -> AnyView? {
          switch contentType {
          case .tv:
               seasonView(viewModel, mediaId)
          case .movie:
               recommendationView(viewModel)
          case .person:
               profilesImages(viewModel)
          }
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
     
     private func profilesImages(_ viewModel: DetailVM) -> AnyView? {
          guard let personDetail = viewModel.detail as? PersonInfo else { return nil }
          let profiles = personDetail.allProFiles().profiles
          guard !profiles.isEmpty else {return nil}
          return AnyView(PersonImageRow(images: profiles))
     }
     
     private func videoUrl() -> URL {
          URL(string: AppUrl.VURL)!
     }
}
