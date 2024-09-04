//
//  HomeView.swift
//  StarzPlayCodeChallengeTV
//
//  Created by Qazi Mudassar on 28/08/2024.
//

import SwiftUI


//struct HomeView: View {
//    var belowFold: Bool
//    
//    var body: some View {
//        Image("beach_landscape")
//            .resizable()
//            .aspectRatio(contentMode: .fill)
//            .overlay {
//                // The view builds the material gradient by filling an area with
//                // a material, and then masking that area using a linear
//                // gradient.
//                Rectangle()
//                    .fill(.regularMaterial)
//                    .mask {
//                        maskView
//                    }
//            }
//            .ignoresSafeArea()
//    }
//
//    var maskView: some View {
//        // The gradient makes direct use of the `belowFold` property to
//        // determine the opacity of its stops.  This way, when `belowFold`
//        // changes, the gradient can animate the change to its opacity smoothly.
//        // If you swap out the gradient with an opaque color, SwiftUI builds a
//        // cross-fade between the solid color and the gradient, resulting in a
//        // strange fade-out-and-back-in appearance.
//        LinearGradient(
//            stops: [
//                .init(color: .black, location: 0.25),
//                .init(color: .black.opacity(belowFold ? 1 : 0.3), location: 0.375),
//                .init(color: .black.opacity(belowFold ? 1 : 0), location: 0.5)
//            ],
//            startPoint: .bottom, endPoint: .top
//        )
//    }
//}
//
//#Preview {
//    HomeView(belowFold: false)
//}
//
//#Preview {
//     HomeView(belowFold: true)
//}
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
