//
//  TVDetailView.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi  Mudassar Tanveer on 08/09/2022.
//

import SwiftUI

struct DetailView: View {
    
    @State private var viewModel: DetailVM
    @State private var goToPlayer = false
    
    private var dynamicContentView: () -> AnyView?
    private var url: URL
    
    init(
        viewModel: DetailVM,
        dynamicContentView: @escaping () -> AnyView?,
        url: URL
    ) {
        self._viewModel = State(wrappedValue: viewModel)
        self.dynamicContentView = dynamicContentView
        self.url = url
    }
    
    var body: some View {
        loadView()
            .fullScreenCover(isPresented: $goToPlayer, content: { VideoPlayerView(url: url) })
            .alert(isPresented: $viewModel.showError, content: {
                Alert(title: Text(viewModel.errorMessage))
            })
    }
}
// MARK: - Load View
extension DetailView {
    func loadView() -> some View {
        ZStack {

            if viewModel.loading {
                LoadingIndicatorView()
            }
            
            ZStack(alignment: .top) {
                ScrollView {
                    ZStack(alignment: .bottom) {
                        GradientImageView(image: viewModel.detail?.getMediaImagePoster() ?? "")
                        bannerImageView()
                    }
                    descripcationView()
                    reactionView()
                    mediaContentView()
                    trailerRow()
                }
                topButtons()
            }
            .edgesIgnoringSafeArea(.top)
            .task {
                await viewModel.getDetail()
            }
            
        }.background(.black)
    }
}
// MARK: - Banner View Funcality
private extension DetailView {
    func topButtons() -> some View {
        HStack {
            Spacer()
            HStack(spacing: 20) {
                Image(systemName: "rectangle")
                    .foregroundColor(.white)
                    .font(Font.system(size: 24, weight: .regular))
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white)
                    .font(Font.system(size: 24, weight: .regular))
                
            }
            
        }.padding(.top, 50)
            .padding([.trailing, .leading])
    }
    
    func bannerImageView() -> some View {
        VStack(alignment: .leading, spacing: 15) {
             if viewModel.detail is PersonInfo {
                  nameAndTypeView()
             } else {
                  nameAndTypeView()
                  playableButtonView()
             }
        }
        .padding([.trailing, .leading])
    }
    
    func nameAndTypeView() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.detail?.getMediaName() ?? "")
                .font(.largeTitle)
                .foregroundColor(.white)
            Text(viewModel.detail?.getSubMedaiDetail() ?? "")
                .font(.system(size: 18, weight: .semibold, design: .default))
                .foregroundColor(.gray)
        }
    }
    
    func playableButtonView() -> some View {
        HStack(spacing: 8) {
            PlayButton(action: {
                goToPlayer.toggle()
            })
            
            Spacer()
            
            TrailerButton(action: {
                goToPlayer.toggle()
            })
        }
    }
    
    func descripcationView() -> some View {
        VStack {
            ExpandableView(viewModel.detail?.getMediaOverView() ?? "")
        }
    }
    
     func mediaContentView() -> some View {
          VStack {
               if viewModel.detail is PersonInfo {
                    dynamicContentView()
                    castView()
               } else {
                    castView()
                    dynamicContentView()
               }
          }
     }
     
     func castView() -> PosterRowView? {
          guard let cast = viewModel.detail?.getCast()?.cast , !cast.isEmpty else { return nil }
          return PosterRowView(layout: Layout(sectionTitle: "Cast", titles: cast))
     }
}
// MARK: - Reaction View
private extension DetailView {
     
     private func trailerRow() -> AnyView? {
          guard !(viewModel.detail is PersonInfo) else { return nil }
          guard let videos = viewModel.getVideos()  else { return nil }
          return AnyView(
               VStack(alignment: .leading, spacing: 10) {
                    Text("Trailers")
                         .font(.title3)
                         .bold()
                         .padding(.horizontal)
                    ScrollView(.horizontal, showsIndicators: false) {
                         LazyHStack(spacing: 13) {
                              ForEach(videos, id: \.id) { video in
                                   WebView(url: AppUrl.YOUTUBE.replace(string: "{key}", with: video.key))
                                        .frame(width: 320, height: 200)
                                        .cornerRadius(10)
                              }
                         }
                         .padding(.horizontal)
                    }
               }
          )
     }
     
     func reactionView() -> AnyView? {
          guard !(viewModel.detail is PersonInfo) else { return nil }
          return AnyView(
               HStack(alignment: .top, spacing: 12) {
                    RoundedButton(iconName: "plus", textName: "Watch List")
                    RoundedButton(iconName: "hand.thumbsup", textName: "I like it")
                    RoundedButton(iconName: "hand.thumbsdown", textName: "I don't like it")
                    Spacer()
               }
                .padding(.top, 10)
                .padding([.trailing, .leading])
          )
     }
}

struct TVDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let app = AppInstantiationFactory()
        app.detailView(for: MediaInfo.theFlash.rawValue, and: .movie)
        app.detailView(for: MediaInfo.theBoys.rawValue, and: .tv).preferredColorScheme(.dark)
    }
}
