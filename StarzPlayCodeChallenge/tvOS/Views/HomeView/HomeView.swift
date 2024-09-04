//
//  HomeView.swift
//  StarzPlayCodeChallengeTV
//
//  Created by Qazi Mudassar on 28/08/2024.
//

import SwiftUI

struct HomeView: View {
     @State var viewModel: HomeViewModel
     
     init(viewModel: HomeViewModel) {
          self._viewModel = State(wrappedValue: viewModel)
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
                         ForEach(viewModel.layouts , id: \.id) { layout in
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
