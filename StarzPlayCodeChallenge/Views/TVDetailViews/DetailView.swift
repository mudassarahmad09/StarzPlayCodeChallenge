//
//  TVDetailView.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi  Mudassar Tanveer on 08/09/2022.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject private var viewModel: DetailVM
    @State private var goToPlayer = false
    
    private var dynamicContentView: () -> AnyView?
    private var url: URL
    
    @Environment(\.dismiss) private var dismiss
    
    init(
        viewModel: DetailVM,
        dynamicContentView: @escaping () -> AnyView?,
        url: URL
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.dynamicContentView = dynamicContentView
        self.url = url
    }
    
    var body: some View {
        loadView()
            .fullScreenCover(isPresented: $goToPlayer, content: {VideoPlayerView(url: url)})
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
                    dynamicContentView()
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
extension DetailView {
    func topButtons() -> some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "arrow.backward")
                    .foregroundColor(.white)
                    .font(Font.system(size: 30, weight: .medium))
            }
            
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
            
            nameAndTypeView()
            playableButtonView()
            
        }
        .padding([.trailing, .leading])
    }
    
    func nameAndTypeView() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.detail?.getMediaName() ?? "")
                .font(.largeTitle)
                .foregroundColor(.white)
            Text("\(viewModel.detail?.getYear() ?? "") | \(viewModel.detail?.getNumberOfSeaosn() ?? 0) Seasons | R")
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
    
}
// MARK: - Reaction View
extension DetailView {
    func reactionView() -> some View {
        HStack(alignment: .top, spacing: 12) {
            RoundedButton(iconName: "plus", textName: "Watch List")
            RoundedButton(iconName: "hand.thumbsup", textName: "I like it")
            RoundedButton(iconName: "hand.thumbsdown", textName: "I don't like it")
            Spacer()
        }
        .padding(.top, 10)
        .padding([.trailing, .leading])
    }
}

struct TVDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let app = AppInstantiationFactory()
        app.detailView(for: SeasonType.theBoys.rawValue, and: .tv)
        app.detailView(for: SeasonType.theBoys.rawValue, and: .tv).preferredColorScheme(.dark)
    }
}
