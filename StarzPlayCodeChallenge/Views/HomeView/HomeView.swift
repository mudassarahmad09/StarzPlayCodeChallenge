//
//  HomeView.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 11/07/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        loadView()
            .alert(isPresented: $viewModel.showError, content: {
                Alert(title: Text(viewModel.errorMessage))
            })
    }
    
    private func loadView() -> some View {
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
            }
        }
        .background(.black)
        .task {
            await viewModel.fetchTvShowsList()
        }
    }
}

struct PosterRowView: View {
    let layout: Layout
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(layout.sectionTitle)
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
                Spacer()
            }.padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 13) {
                    ForEach(layout.titles, id: \.id) { title in
                        NavigationLink {
                            let detailView = AppInstantiationFactory().tvDetailView(seasonId: title.id)
                            HideNavbarOf(view: detailView)
                        } label: {
                            PosterView(mediaItem: title)
                        }
                    }
                }
                .padding(.horizontal, 13)
                .padding(.top, 10)
            }
        }
    }
}

struct PosterView: View {
    let mediaItem: Title
    let width: CGFloat = 110
    let height: CGFloat = 160
    let alpha: CGFloat = 0.45
    
    var body: some View {
        VStack(alignment: .leading) {
            
            AsyncImageView(url:
                            URL(string: AppUrl.IMAGEURL + (mediaItem.imagePoster ))!,
                           placeHolder: .placeHolder,
                           width: width,
                           height: height)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(mediaItem.title)
                    .foregroundColor(.white)
                    .font(.headline)
                    .lineLimit(2)
                Text(mediaItem.subTitle)
                    .foregroundColor(.white)
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
        let app = AppInstantiationFactory()
        app.startApp()
    }
}
