//
//  PersonDetailVIew.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 10/08/2023.
//

import SwiftUI

struct PersonDetailView: View {
    @StateObject private var viewModel: PersonDetailVM
    @Environment(\.dismiss) private var dismiss
    
    init(viewModel: PersonDetailVM) {
        self._viewModel = StateObject(wrappedValue: viewModel)
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
                        GradientImageView(image: viewModel.detail?.getImagePoster() ?? "")
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
            Button {
                dismiss()
            } label: {
                Image(systemName: "arrow.backward")
                    .foregroundColor(.white)
                    .font(Font.system(size: 30, weight: .medium))
            }
            
            Spacer()
            
        }.padding(.top, 50)
            .padding([.trailing, .leading])
    }
    
    private func nameView() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.detail?.getName() ?? "")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Text("Date Of Birthday \(viewModel.detail?.getBirthDay() ?? "")")
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
            ExpandableView(viewModel.detail?.getOverView() ?? "")
        }
    }
    
    private func profilesImages() -> AnyView? {
        guard let profiles = viewModel.detail?.allProFiles().profiles,
              !profiles.isEmpty else {return nil}
        return AnyView(PersonImageRow(images: profiles))
    }
    private func castView() -> AnyView? {
        guard let cast = viewModel.detail?.getCast().cast,
              !cast.isEmpty else {return nil}
        return AnyView(PosterRowView(layout:
                                        Layout(sectionTitle: "Movies and TVs",
                                               titles: cast)))
    }
}
struct PersonDetailVIew_Preview: PreviewProvider {
    static var previews: some View {
        let app = AppInstantiationFactory()
        app.detailView(for:MediaInfo.thePerson.rawValue , and: .person)
    }
}


