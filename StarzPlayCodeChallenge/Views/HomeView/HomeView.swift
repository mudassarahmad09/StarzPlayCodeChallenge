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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let app = AppInstantiationFactory()
        app.startApp()
    }
}
