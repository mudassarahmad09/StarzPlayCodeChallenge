//
//  PersonDetailVIew.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 10/08/2023.
//

import SwiftUI

struct PersonDetailView: View {
    @State private var viewModel: PersonDetailVM

    init(viewModel: PersonDetailVM) {
        self._viewModel = State(wrappedValue: viewModel)
    }
        
    var body: some View{
        load()
            .alert(isPresented: $viewModel.showError, content: {
                Alert(title: Text(viewModel.errorMessage))
            })
    }
}
private extension PersonDetailView {
    
    private func load() -> some View {
        ZStack {
            
            if viewModel.loading {
                LoadingIndicatorView()
            }
            
            ZStack(alignment: .top) {
                ScrollView {
                    ZStack(alignment: .bottomLeading) {
                        GradientImageView(image: viewModel.detail?.getMediaImagePoster() ?? "")
                        nameView()
                    }
                    descripcationView()
                    profilesImages()
                    castView()
                }
                topButtons()
            }
            .edgesIgnoringSafeArea(.top)
            .task {
                await viewModel.getDetail()
            }
        }.background(.black)
    }
    
    func topButtons() -> some View {
        HStack {
            
            Spacer()
            
        }.padding(.top, 50)
            .padding([.trailing, .leading])
    }
    
    private func nameView() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.detail?.getMediaName() ?? "")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Text(viewModel.detail?.getSubMedaiDetail() ?? "")
                    .font(.system(size: 18, weight: .semibold, design: .default))
                    .foregroundColor(.gray)
                
                born()
            }
        }
        .padding([.trailing, .leading])
    }
    
    func born() -> AnyView? {
        guard let born = viewModel.detail?.getBorn() else {return nil}
        return AnyView(Text("Born in \(born)")
            .font(.title3)
            .fontWeight(.regular))
        
    }
    
    private func descripcationView() -> some View {
        VStack {
            ExpandableView(viewModel.detail?.getMediaOverView() ?? "")
        }
    }
    
    private func profilesImages() -> AnyView? {
        guard let profiles = viewModel.detail?.allProFiles().profiles,
              !profiles.isEmpty else {return nil}
        return AnyView(PersonImageRow(images: profiles))
    }
     
    private func castView() -> AnyView? {
         guard let cast = viewModel.detail?.getCast()?.cast,
              !cast.isEmpty else {return nil}
        return AnyView(PosterRowView(layout:
                                        Layout(sectionTitle: "Movies and TVs",
                                               titles: cast)))
    }
}

#Preview {
     let app = AppInstantiationFactory()
     return app.detailView(for:MediaInfo.thePerson.rawValue , and: .person)
}
