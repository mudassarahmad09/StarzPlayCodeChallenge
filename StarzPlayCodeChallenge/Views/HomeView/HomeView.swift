//
//  HomeView.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 11/07/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = HomeViewModel(tvShowsService: TVShowsServiceAdapter())
    
    var body: some View {
        ZStack {
            
            if viewModel.loading {
                LoadingIndicatorView()
            }
            
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(viewModel.layouts ?? [], id: \.id) { layout in
                        PosterRowView(layout: layout)
                    }
                }
            }.task {
                await viewModel.fetchTvShowsList()
            }
        }
        
    }
}

struct PosterRowView: View {
     let layout: Layout
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(layout.title)
                    .font(.title3)
                    .bold()
                Spacer()
            }.padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 13) {
                    ForEach(layout.tvShows, id: \.name) { tvShow in
                        PosterView(tvShow: tvShow)
                    }
                }
                .padding(.horizontal, 13)
                .padding(.top, 10)
            }
        }
    }
}

struct PosterView: View {
    let tvShow: TVShows
    let width: CGFloat = 110
    let height: CGFloat = 160
    let alpha: CGFloat = 0.45
    
    var body: some View {
        VStack(alignment: .leading) {
            
            AsyncImageView(url:
                            URL(string: AppUrl.IMAGEURL + (tvShow.posterPath ))!,
                           placeHolder: .placeHolder,
                           width: width,
                           height: height)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(tvShow.name)
                    .font(.headline)
                    .lineLimit(2)
                Text(tvShow.firstAirDate)
                    .font(.subheadline)
                    .lineLimit(1)
                
            }
            .frame(minHeight: height * alpha, alignment: .top)
        }
        .frame(width: width)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


